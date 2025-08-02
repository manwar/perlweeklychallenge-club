#[allow(warnings)]
mod bindings;

use bindings::exports::ringlet::pwc317_t2_frings::frings::Guest;

struct Component;

#[derive(Debug)]
enum State {
    Same,
    SingleDiff(char, char),
    DoubleDiff,
    Different,
}

fn frings_update(state: State, chars: (char, char)) -> State {
    match state {
        State::Same => {
            if chars.0 == chars.1 {
                State::Same
            } else {
                State::SingleDiff(chars.0, chars.1)
            }
        }

        State::SingleDiff(diff0, diff1) => {
            if chars.0 == chars.1 {
                State::SingleDiff(diff0, diff1)
            } else if (chars.0 == diff1) && (chars.1 == diff0) {
                State::DoubleDiff
            } else {
                State::Different
            }
        }

        State::DoubleDiff => {
            if chars.0 == chars.1 {
                State::DoubleDiff
            } else {
                State::Different
            }
        }

        State::Different => State::Different,
    }
}

impl Guest for Component {
    /// Determine whether two strings are friendly enough.
    fn frings(str1: String, str2: String) -> bool {
        if str1.len() != str2.len() {
            return false;
        }

        let state = str1
            .chars()
            .zip(str2.chars())
            .fold(State::Same, frings_update);
        matches!(state, State::DoubleDiff)
    }
}

bindings::export!(Component with_types_in bindings);
