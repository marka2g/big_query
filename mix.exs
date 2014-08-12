defmodule BigQuery.Mixfile do
  use Mix.Project

  def project do
    [app: :big_query,
     version: "0.0.1",
     elixir: "~> 0.15.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: [:logger, :ssl, :inets]
    ]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:simple_oauth2, github: "virtan/simple_oauth2"},
      # {:cowboy, "1.0.0", github: "extend/cowboy"}
      {:cowboy, github: "extend/cowboy", tag: "0.9.0"}
    ]
  end
end
