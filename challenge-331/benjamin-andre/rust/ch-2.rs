#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn buddy_strings(source: &str, target: &str) -> bool {
    if source.len() != target.len() {
        return false;
    }
    let s: Vec<char> = source.chars().collect();
    let t: Vec<char> = target.chars().collect();
    let diffs: Vec<usize> = (0..s.len()).filter(|&i| s[i] != t[i]).collect();
    match diffs.len() {
        0 => s.len() != s.iter().collect::<std::collections::HashSet<_>>().len(),
        2 => s[diffs[0]] == t[diffs[1]] && s[diffs[1]] == t[diffs[0]],
        _ => false,
    }
}

#[test]
fn example() {
    assert_eq!(buddy_strings("fuck", "fcuk"), true);
    assert_eq!(buddy_strings("love", "love"), false);
    assert_eq!(buddy_strings("fodo", "food"), true);
    assert_eq!(buddy_strings("feed", "feed"), true);
}
