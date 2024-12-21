defmodule Omdb.MixProject do
  use Mix.Project

  def project do
    [
      app: :omdb,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "A Thin Wrapper for the OMDB API",
      package: package(),
      source_url: "https://github.com/soolaimon/omdb"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Omdb.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.19"},
      {:mix_test_watch, "1.2.0", only: [:dev, :test]},
      {:mimic, "~> 1.10", only: :test}
    ]
  end

  defp package() do
    [
      name: "omdb",
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Dave Nelson"],
      licenses: ["Apache-2.0"],
      links: %{"OMDB" => "https://www.omdbapi.com/"}
    ]
  end
end
