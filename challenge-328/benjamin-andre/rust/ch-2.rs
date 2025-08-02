#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn good_string(s: &str) -> String {
    let mut stack: Vec<char> = Vec::new();
    for c in s.chars() {
        if let Some(&top) = stack.last() {
            if top != c && top.eq_ignore_ascii_case(&c) {
                stack.pop();
                continue;
            }
        }
        stack.push(c);
    }
    stack.into_iter().collect()
}

#[test]
fn example() {
    assert_eq!(good_string("WeEeekly"), "Weekly");
    assert_eq!(good_string("abBAdD"), "");
    assert_eq!(good_string("abc"), "abc");
}
