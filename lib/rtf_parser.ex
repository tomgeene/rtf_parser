defmodule RtfParser do
  @moduledoc """
  `RtfParser` is a package that can be used to parse a RTF document.

  This module contains two functions:
  - `scan/1` scans the given RTF document and returns a list of tokens.
  - `parse/1` parses the given list of tokens and returns a structured RTF document.

  To following example shows the basic usage of the `RtfParser` package:

  ```elixir
  rtf = "{\\rtf1\\ansi\\ansicpg1252\\deff0\\nouicompat\\deflang1033{\\fonttbl{\\f0\\fnil\\fcharset0 Calibri;}}\n{\\*\\generator Riched20 10.0.18362}\\viewkind4\\uc1 \n\\pard\\sa200\\sl276\\slmult1\\f0\\fs22\\lang9 This is a \\b RTF document\\b0 with some more text\\par\n}\n"
  {:ok, tokens} = RtfParser.scan(rtf)
  {:ok, document} = RtfParser.parse(tokens)
  IO.inspect(document)
  ```
  """
  use Rustler, otp_app: :rtf_parser, crate: "rtfparser"

  @doc """
  This function scans the given RTF document and returns a list of tokens.
  These tokens represent the RTF document in a structured way.
  """
  @spec scan(binary()) :: [map()]
  def scan(_rtf), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  This function parses the given list of tokens and returns a structured RTF document.

  The structured RTF document is represented as a `RtfDocument` struct.

  The `RtfDocument` contains a `Header` struct and a list of `StyleBlock` structs.
  A `StyleBlock` struct contains all information about the formatting of a
  specific block of text. It contains a `Painter` struct and a `Paragraph` struct.
  Lastly it contains the actual text of the block.
  """
  @spec parse([map()]) :: RtfDocument.t()
  def parse(_tokens), do: :erlang.nif_error(:nif_not_loaded)

  defmodule RtfDocument do
    @moduledoc """
    `RtfParser.RtfDocument` is a struct that represents a parsed RTF document.
    """
    defstruct header: %{}, body: []
  end

  defmodule Header do
    @moduledoc """
    `RtfParser.Header` is a struct that represents the header of a parsed RTF document.
    """
    defstruct character_set: 0, font_table: []
  end

  defmodule StyleBlock do
    @moduledoc """
    `RtfParser.StyleBlock` is a struct that represents a style block of a parsed RTF document.
    """
    defstruct painter: %{}, paragraph: %{}, text: ""
  end

  defmodule Painter do
    @moduledoc """
    `RtfParser.Painter` is a struct that represents the painter of a parsed RTF document.
    """
    defstruct font_ref: %{},
              font_size: 0,
              bold: false,
              italic: false,
              underline: false,
              superscript: false,
              subscript: false,
              smallcaps: false,
              strike: false
  end

  defmodule Paragraph do
    @moduledoc """
    `RtfParser.Paragraph` is a struct that represents a paragraph of a parsed RTF document.
    """
    defstruct alignment: :left_aligned, spacing: %{}, indent: %{}, tab_width: 0
  end

  defmodule Spacing do
    @moduledoc """
    `RtfParser.Spacing` is a struct that represents the spacing of a parsed RTF document.
    """
    defstruct before: 0, after: 0, between_line: :auto, line_multiplier: 1
  end

  defmodule Indentation do
    @moduledoc """
    `RtfParser.Indent` is a struct that represents the indent of a parsed RTF document.
    """
    defstruct left: 0, right: 0, first_line: 0
  end

  defmodule Font do
    @moduledoc """
    `RtfParser.Font` is a struct that represents a font of a parsed RTF document.
    """
    defstruct name: "", character_set: 0, font_family: nil
  end

  defmodule StyleSheet do
  end
end
