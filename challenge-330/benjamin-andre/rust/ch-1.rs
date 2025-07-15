#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn clear_digits(s: &str) -> String {
    let mut chars: Vec<char> = s.chars().collect();
    let mut i = 0;
    while i < chars.len() {
        if chars[i].is_ascii_digit() {
            chars.remove(i);
            if i > 0 {
                chars.remove(i - 1);
                i -= 1;
            }
        } else {
            i += 1;
        }
    }
    chars.into_iter().collect()
}

#[test]
fn example() {
    assert_eq!(clear_digits("cab12"), "c");
    assert_eq!(clear_digits("xy99"), "");
    assert_eq!(clear_digits("pa1erl"), "perl");
}
