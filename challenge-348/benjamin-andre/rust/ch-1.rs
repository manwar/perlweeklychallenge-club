#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn string_alike(s: &str) -> bool {
    let mid = s.len() / 2;
    let count_vowels = |s: &str| s.chars().filter(|c| "aeiouAEIOU".contains(*c)).count();
    count_vowels(&s[..mid]) == count_vowels(&s[mid..])
}

#[test]
fn example() {
    assert_eq!(string_alike("textbook"), false);
    assert_eq!(string_alike("book"), true);
    assert_eq!(string_alike("AbCdEfGh"), true);
    assert_eq!(string_alike("rhythmmyth"), true);
    assert_eq!(string_alike("UmpireeAudio"), false);
}
