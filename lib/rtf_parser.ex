defmodule RtfParser do
  @moduledoc """
  `RtfParser` is a package that can be used to convert a RTF document into plain text.

  It uses a Rust NIF to extract all text blocks from the RTF document and return them
  as a list of binaries.
  """
  use Rustler, otp_app: :rtf_parser, crate: "rtfparser"

  @doc """
  Converts a RTF document to plain text. The function takes a single binary as argument
  and returns a list of binaries, where each binary is a block of text  in the RTF document.

  ## Examples

      iex> RtfParser.rtf_to_text(~S"{ \\rtf1\\ansi{\\fonttbl\\f0\\fswiss Helvetica;}\\f0\\pard This is a {\\b RTF document} with some text\\par }")
      ["This is a", "RTF document", "with some text"]

  """
  @spec rtf_to_text(binary()) :: [binary()]
  def rtf_to_text(_rtf), do: :erlang.nif_error(:nif_not_loaded)
end
