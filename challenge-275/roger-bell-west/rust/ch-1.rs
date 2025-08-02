#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(brokenkeys("Perl Weekly Challenge", vec!['l', 'a']), 0);
}

#[test]
fn test_ex2() {
    assert_eq!(brokenkeys("Perl and Raku", vec!['a']), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(brokenkeys("Well done Team PWC", vec!['l', 'o']), 2);
}

#[test]
fn test_ex4() {
    assert_eq!(brokenkeys("The joys of polyglottism", vec!['T']), 2);
}

fn brokenkeys(a: &str, k: Vec<char>) -> u32 {
    let mut out = 0;
    let failset =
        k.iter().map(|c| c.to_ascii_lowercase()).collect::<HashSet<char>>();
    for word in a.split(' ') {
        let wordset =
            word.to_ascii_lowercase().chars().collect::<HashSet<char>>();
        if wordset.intersection(&failset).count() == 0 {
            out += 1;
        }
    }
    out
}
