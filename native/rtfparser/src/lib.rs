use rtf_parser::{Lexer, Parser};

#[rustler::nif(schedule = "DirtyCpu")]
fn rtf_to_text(rtf: String) -> Vec<String> {
    let tokens = std::panic::catch_unwind(|| Lexer::scan(&rtf.trim()));
    let tokens = match tokens {
        Ok(tokens) => tokens,
        Err(_e) => {
            return vec![];
        }
    };

    let doc = std::panic::catch_unwind(|| Parser::new(tokens).parse());
    let doc = match doc {
        Ok(doc) => doc,
        Err(_e) => {
            return vec![];
        }
    };

    doc
        .body
        .iter()
        .map(|block| block.text.trim().to_string())
        .filter(|s| !s.is_empty())
        .collect()
}

rustler::init!("Elixir.RtfParser", [rtf_to_text]);
