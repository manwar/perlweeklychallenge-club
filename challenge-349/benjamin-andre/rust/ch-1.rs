#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn power_string(s: &str) -> usize {
    let chars: Vec<char> = s.chars().collect();
    let mut max_len = 0;
    let mut i = 0;
    while i < chars.len() {
        let mut j = i;
        while j < chars.len() && chars[j] == chars[i] {
            j += 1;
        }
        max_len = max_len.max(j - i);
        i = j;
    }
    max_len
}

#[test]
fn example() {
    assert_eq!(power_string("textbook"), 2);
    assert_eq!(power_string("aaaaa"), 5);
    assert_eq!(power_string("hoorayyy"), 3);
    assert_eq!(power_string("x"), 1);
    assert_eq!(power_string("aabcccddeeffffghijjk"), 4);
}
