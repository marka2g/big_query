defmodule BigQuery do
  # defdelegate projects,                       to: BigQuery.API.Base
  # defdelegate datasets(project),              to: BigQuery.API.Base
  # defdelegate jobs(project),                  to: BigQuery.API.Base
  # defdelegate query(project, query),          to: BigQuery.API.Base
  # defdelegate query(project, query, options), to: BigQuery.API.Base
  use OAuth2Ex.Client

  @project_id System.get_env("GOOGLE_BIG_QUERY_PROJECT_ID")

  @doc """
  Returns the target project_id for the BigQuery API.
  """
  def project_id, do: @project_id

  @doc """
  Client configuration setting for specifying required parameters
  for accessing OAuth 2.0 server.
  """
  def config do
    OAuth2Ex.config(
      id:            System.get_env("GOOGLE_API_CLIENT_ID"),
      secret:        System.get_env("GOOGLE_API_CLIENT_SECRET"),
      authorize_url: "https://accounts.google.com/o/oauth2/auth",
      token_url:     "https://accounts.google.com/o/oauth2/token",
      scope:         "https://www.googleapis.com/auth/bigquery",
      callback_url:  "http://localhost:4000",
      token_store:   %OAuth2Ex.FileStorage{
                       file_path: System.user_home <> "/oauth2ex.google.token"}
    )
  end

  def url_for(path) do
    "https://www.googleapis.com/bigquery/v2/#{path}"
  end

  @doc """
  List the projects by calling Google BigQuery API - project list.
  API: https://developers.google.com/bigquery/docs/reference/v2/#Projects
  """
  def projects do
    url_for("projects") |> get |> fetch_body
  end

  def datasets do
    url_for("projects/#{project_id}/datasets") |> get |> fetch_body
  end

  def dataset(dataset_id) do
    url_for("projects/#{project_id}/datasets/#{dataset_id}") |> get |> fetch_body
  end

  def tables(dataset_id) do
    url_for("projects/#{project_id}/datasets/#{dataset_id}/tables") |> get |> fetch_body
  end

  def jobs(stateFilter \\ "running") do
    params = [stateFilter: stateFilter]
    url_for("projects/#{project_id}/jobs") |> get(params) |> fetch_body
  end

  def query do
    params = %{
      "kind": "bigquery#queryRequest",
      "query": "SELECT kind, name, population FROM [sample_dataset.sample_table] LIMIT 1000",
      "defaultDataset": %{
        "datasetId": "sample_dataset",
        "projectId": "ktsquall"
      }
    }

    body = url_for("projects/#{project_id}/queries") |> post(params) |> fetch_body
    parse_query_result(body["rows"])
  end

  defp fetch_body(response) do
    if response.status_code < 200 or response.status_code > 200 do
      raise "Error response was returned from server. status_code: #{response.status_code}, body: #{response.body}"
    else
      response.body
    end
  end

  def parse_query_params(params) do
    params |> Enum.map(fn({k,v}) -> "#{k}=#{v}" end)
           |> Enum.join("&")
  end

  def parse_query_result(rows) do
    rows |> Enum.map(fn(data) -> parse_row(data["f"]) end)
  end

  def parse_row(row) do
    row |> Enum.map(fn(data) -> data["v"] end)
  end
end
