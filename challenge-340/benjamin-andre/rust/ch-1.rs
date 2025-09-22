#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn duplicate_removals(s: &str) -> String {
    let mut stack = Vec::new();
    for c in s.chars() {
        if stack.last() == Some(&c) {
            stack.pop();
        } else {
            stack.push(c);
        }
    }
    stack.into_iter().collect()
}

#[test]
fn example() {
    assert_eq!(duplicate_removals("abbaca"), "ca");
    assert_eq!(duplicate_removals("azxxzy"), "ay");
    assert_eq!(duplicate_removals("aaaaaaaa"), "");
    assert_eq!(duplicate_removals("aabccba"), "a");
    assert_eq!(duplicate_removals("abcddcba"), "");
}
