defmodule BigQuery do
  defdelegate projects, to: BigQuery.API.Projects

  defdelegate query(query_string, dataset_id), to: BigQuery.API.Jobs

  defdelegate jobs,              to: BigQuery.API.Jobs
  defdelegate jobs(stateFilter), to: BigQuery.API.Jobs

  defdelegate datasets,             to: BigQuery.API.Datasets
  defdelegate datasets(dataset_id), to: BigQuery.API.Datasets

  defdelegate tables, to: BigQuery.API.Tables
  defdelegate create_table(dataset_id, table_id, fields), to: BigQuery.API.Tables
  defdelegate delete_table(dataset_id, table_id), to: BigQuery.API.Tables

  defdelegate insert_all(dataset_id, table_id, rows), to: BigQuery.API.Tabledata

  defdelegate list_data(dataset_id, table_id),                           to: BigQuery.API.Tabledata
  defdelegate list_data(dataset_id, table_id, start_index),              to: BigQuery.API.Tabledata
  defdelegate list_data(dataset_id, table_id, start_index, max_results), to: BigQuery.API.Tabledata
end
