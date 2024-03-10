defmodule RtfParserTest do
  use ExUnit.Case
  doctest RtfParser

  @test_rtf ~S"{ \rtf1\ansi{\fonttbl\f0\fswiss Helvetica;}\f0\pard This is a {\b RTF document} with some more text\par }"

  @expected_output ["This is a", "RTF document", "with some more text"]

  test "parsing RTF to text" do
    assert RtfParser.rtf_to_text(@test_rtf) == @expected_output
  end
end
