use find_third;

#[allow(warnings)]
mod bindings;

use bindings::exports::ringlet::pwc315_t2_find_third::find_third::Guest;

struct Component;

impl Guest for Component {
    fn find_third(sentence: String, wfirst: String, wsecond: String) -> Vec<String> {
        find_third::find_third(sentence, wfirst, wsecond)
    }
}

bindings::export!(Component with_types_in bindings);
