//! Weekly challenge 315 task 1 - find words containing a character.

use find_words;

#[allow(warnings)]
#[allow(clippy)]
mod bindings;

use bindings::exports::ringlet::pwc315_t1_find_words::find_words::Guest;

struct Component;

impl Guest for Component {
    fn find_words(wlist: Vec<String>, wchar: char) -> Vec<u32> {
        find_words::find_words(wlist, wchar)
    }
}

bindings::export!(Component with_types_in bindings);
