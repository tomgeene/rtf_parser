defmodule RtfParserTest do
  use ExUnit.Case

  @test_rtf ~S"{ \rtf1\ansi{\fonttbl\f0\fswiss Helvetica;}\f0\pard This is a {\b RTF document} with some more text\par }"

  @expected_document %RtfParser.RtfDocument{
    header: %{
      __struct__: RtfParser.RtfHeader,
      font_table: %{
        0 => %RtfParser.Font{
          name: "Helvetica",
          character_set: 0,
          font_family: :swiss
        }
      },
      character_set: :ansi,
      stylesheet: %{__struct__: RtfParser.StyleSheet}
    },
    body: [
      %RtfParser.StyleBlock{
        painter: %RtfParser.Painter{
          font_ref: 0,
          font_size: 12,
          bold: false,
          italic: false,
          underline: false,
          superscript: false,
          subscript: false,
          smallcaps: false,
          strike: false
        },
        paragraph: %RtfParser.Paragraph{
          alignment: :left_aligned,
          spacing: %RtfParser.Spacing{
            before: 0,
            after: 0,
            between_line: :auto,
            line_multiplier: 0
          },
          indent: %RtfParser.Indentation{left: 0, right: 0, first_line: 0},
          tab_width: 0
        },
        text: "This is a "
      },
      %RtfParser.StyleBlock{
        painter: %RtfParser.Painter{
          font_ref: 0,
          font_size: 12,
          bold: true,
          italic: false,
          underline: false,
          superscript: false,
          subscript: false,
          smallcaps: false,
          strike: false
        },
        paragraph: %RtfParser.Paragraph{
          alignment: :left_aligned,
          spacing: %RtfParser.Spacing{
            before: 0,
            after: 0,
            between_line: :auto,
            line_multiplier: 0
          },
          indent: %RtfParser.Indentation{left: 0, right: 0, first_line: 0},
          tab_width: 0
        },
        text: "RTF document"
      },
      %RtfParser.StyleBlock{
        painter: %RtfParser.Painter{
          font_ref: 0,
          font_size: 12,
          bold: false,
          italic: false,
          underline: false,
          superscript: false,
          subscript: false,
          smallcaps: false,
          strike: false
        },
        paragraph: %RtfParser.Paragraph{
          alignment: :left_aligned,
          spacing: %RtfParser.Spacing{
            before: 0,
            after: 0,
            between_line: :auto,
            line_multiplier: 0
          },
          indent: %RtfParser.Indentation{left: 0, right: 0, first_line: 0},
          tab_width: 0
        },
        text: " with some more text"
      }
    ]
  }

  test "parse" do
    assert {:ok, parsed} = RtfParser.parse(@test_rtf)
    assert parsed == @expected_document
  end

  test "parse with invalid RTF" do
    assert {:error, :no_more_token} = RtfParser.parse("")
  end
end
