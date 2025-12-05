#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn good_substrings(s: &str) -> usize {
    let chars: Vec<char> = s.chars().collect();
    (0..chars.len().saturating_sub(2))
        .filter(|&i| {
            let a = chars[i];
            let b = chars[i + 1];
            let c = chars[i + 2];
            a != b && b != c && a != c
        })
        .count()
}

#[test]
fn example() {
    assert_eq!(good_substrings("abcaefg"), 5);
    assert_eq!(good_substrings("xyzzabc"), 3);
    assert_eq!(good_substrings("aababc"), 1);
    assert_eq!(good_substrings("qwerty"), 4);
    assert_eq!(good_substrings("zzzaaa"), 0);
}
