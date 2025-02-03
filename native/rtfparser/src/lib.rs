// RTF parser for Text Editor
// This library supports RTF version 1.9.1
// Specification is available here : https://dokumen.tips/documents/rtf-specification.html
// Explanations on specification here : https://www.oreilly.com/library/view/rtf-pocket-guide/9781449302047/ch01.html

#![allow(irrefutable_let_patterns)]

use std::fmt;
use rustler::NifTaggedEnum;

// Public API of the crate
pub mod document;
pub mod header;
pub mod lexer;
pub mod paragraph;
pub mod parser;
pub mod tokens;
mod utils;

#[derive(Debug, Clone, NifTaggedEnum)]
pub enum RtfError {
    Error(String),
    InvalidUnicode(String),
    InvalidLastChar,
    InvalidToken(String),
    IgnorableDestinationParsingError,
    MalformedPainterStack,
    InvalidFontIdentifier(tokens::Property),
    NoMoreToken,
}

impl std::error::Error for RtfError {}

impl fmt::Display for RtfError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let _ = write!(f, "[RTF Parser] : ");
        let _ = match self {
            RtfError::InvalidLastChar => write!(f, "Invalid last char, should be '}}'"),
            RtfError::InvalidUnicode(uc) => write!(f, "Invalid unicode : {uc}"),
            RtfError::Error(msg) => write!(f, "{}", msg),
            RtfError::InvalidToken(msg) => write!(f, "{}", msg),
            RtfError::IgnorableDestinationParsingError => write!(f, "No ignorable destination should be left"),
            RtfError::MalformedPainterStack => write!(f, "Malformed painter stack : Unbalanced number of brackets"),
            RtfError::InvalidFontIdentifier(property) => write!(f, "Invalid font identifier : {:?}", property),
            RtfError::NoMoreToken => write!(f, "No more token to parse"),
        };
        return Ok(());
    }
}

impl From<parser::ParserError> for RtfError {
    fn from(error: parser::ParserError) -> Self {
        match error {
            parser::ParserError::InvalidToken(uc) => RtfError::InvalidToken(uc),
            parser::ParserError::IgnorableDestinationParsingError => RtfError::IgnorableDestinationParsingError,
            parser::ParserError::MalformedPainterStack => RtfError::MalformedPainterStack,
            parser::ParserError::InvalidFontIdentifier(property) => RtfError::InvalidFontIdentifier(property),
            parser::ParserError::NoMoreToken => RtfError::NoMoreToken,
        }
    }
}

impl From<lexer::LexerError> for RtfError {
    fn from(error: lexer::LexerError) -> Self {
        match error {
            lexer::LexerError::InvalidLastChar => RtfError::InvalidLastChar,
            lexer::LexerError::InvalidUnicode(uc) => RtfError::InvalidUnicode(uc),
            lexer::LexerError::Error(msg) => RtfError::Error(msg),
        }
    }
}

// #[rustler::nif]
// fn scan(input: &str) -> Result<Vec<tokens::Token>, lexer::LexerError> {
//     crate::lexer::Lexer::scan(input)
// }

#[rustler::nif]
fn parse(input: &str) -> Result<document::RtfDocument, RtfError> {
    let tokens = crate::lexer::Lexer::scan(input)?;
    match crate::parser::Parser::new(tokens).parse() {
        Ok(document) => Ok(document),
        Err(err) => Err(err.into()),
    }
}

rustler::init!("Elixir.RtfParser");