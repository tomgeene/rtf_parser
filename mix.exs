defmodule RtfParser.MixProject do
  use Mix.Project

  def project do
    [
      app: :rtf_parser,
      version: "1.1.1",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.36.1", runtime: false},
      {:ex_doc, "~> 0.36.1", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    """
    Library for converting RTF to plain text using Rust NIF.
    """
  end

  defp package do
    [
      files:
        ~w(lib priv .formatter.exs mix.exs README* LICENSE* native/rtfparser/src native/rtfparser/.cargo native/rtfparser/README* native/rtfparser/Cargo*),
      maintainers: ["Tom Geene"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tomgeene/rtf_parser"}
    ]
  end
end
