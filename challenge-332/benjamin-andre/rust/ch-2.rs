#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn odd_letters(s: &str) -> bool {
    let mut counts = std::collections::HashMap::new();
    for c in s.chars() {
        *counts.entry(c).or_insert(0) += 1;
    }
    counts.values().all(|&count| count % 2 == 1)
}

#[test]
fn example() {
    assert_eq!(odd_letters("weekly"), false);
    assert_eq!(odd_letters("perl"), true);
    assert_eq!(odd_letters("challenge"), false);
}
