# RtfParser

This is a simple RTF parser written in Elixir. It uses a rust NIF to parse the RTF document and convert it to plain text. The rust NIF is a simple wrapper around the `rtf-parser` crate, which can
be found on [crates.io](https://crates.io/crates/rtf-parser).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `rtf_parser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rtf_parser, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/rtf_parser>.

