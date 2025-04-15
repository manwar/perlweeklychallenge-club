#[allow(warnings)]
mod bindings;

use bindings::exports::ringlet::pwc317_t1_acronyms::acronyms::Guest;

struct Component;

impl Guest for Component {
    /// Determine whether a word is an acronym for a series of other words.
    fn acronyms(wlist: Vec<String>, word: String) -> bool {
        word == wlist
            .iter()
            .map(|word| word.chars().next().unwrap())
            .collect::<String>()
    }
}

bindings::export!(Component with_types_in bindings);
