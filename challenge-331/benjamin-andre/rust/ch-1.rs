#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn last_word(s: &str) -> usize {
    s.trim()
        .split_whitespace()
        .last()
        .map_or(0, |word| word.len())
}

#[test]
fn example() {
    assert_eq!(last_word("The Weekly Challenge"), 9);
    assert_eq!(last_word("   Hello   World    "), 5);
    assert_eq!(last_word("Let's begin the fun"), 3);
}
