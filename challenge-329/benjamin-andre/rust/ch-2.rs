#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

// Ok this is kind of ugly, but hey it works
fn nice_string(s: &str) -> &str {
    let mut longest = "";
    for i in 0..s.len() {
        for j in i..s.len() {
            let sub = &s[i..=j];
            if sub.chars().all(|c| {
                !c.is_ascii_alphabetic()
                    || sub.contains(c.to_ascii_lowercase()) && sub.contains(c.to_ascii_uppercase())
            }) && sub.len() > longest.len()
            {
                longest = sub;
            }
        }
    }
    longest
}

#[test]
fn example() {
    assert_eq!(nice_string("YaaAho"), "aaA");
    assert_eq!(nice_string("cC"), "cC");
    assert_eq!(nice_string("A"), "");
}
