defmodule BigQuery.Mixfile do
  use Mix.Project

  def project do
    [app: :big_query,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [ applications: [:logger, :extwitter, :oauth2ex] ]
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
      {:oauth2ex, "0.0.8"},
      {:extwitter, "~> 0.5"},
      {:oauth, github: "tim/erlang-oauth"}
    ]
  end
end
