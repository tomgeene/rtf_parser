// RTF parser for Text Editor
// This library supports RTF version 1.9.1
// Specification is available here : https://dokumen.tips/documents/rtf-specification.html
// Explanations on specification here : https://www.oreilly.com/library/view/rtf-pocket-guide/9781449302047/ch01.html

#![allow(irrefutable_let_patterns)]

// Public API of the crate
pub mod document;
pub mod header;
pub mod lexer;
pub mod paragraph;
pub mod parser;
pub mod tokens;
mod utils;

#[rustler::nif]
fn scan(input: &str) -> Result<Vec<tokens::Token>, lexer::LexerError> {
    crate::lexer::Lexer::scan(input)
}

#[rustler::nif]
fn parse(tokens: Vec<tokens::Token>) -> Result<document::RtfDocument, parser::ParserError> {
    crate::parser::Parser::new(tokens).parse()
}

rustler::init!("Elixir.RtfParser", [scan, parse]);