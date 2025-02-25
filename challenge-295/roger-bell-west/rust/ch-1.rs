#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(wordbreak("weeklychallenge", vec!["challenge", "weekly"]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(wordbreak("perlrakuperl", vec!["raku", "perl"]), true);
}

#[test]
fn test_ex3() {
    assert_eq!(
        wordbreak("sonsanddaughters", vec!["sons", "sand", "daughters"]),
        false
    );
}

fn wordbreak(a: &str, words: Vec<&str>) -> bool {
    let mut queue: VecDeque<String> = VecDeque::new();
    queue.push_back(a.to_string());
    while let Some(remnant) = queue.pop_front() {
        if remnant.len() == 0 {
            return true;
        }
        for candidate in &words {
            if remnant.starts_with(candidate) {
                let (_x, y) = remnant.split_at(candidate.len());
                queue.push_back(y.to_string());
            }
        }
    }
    false
}
