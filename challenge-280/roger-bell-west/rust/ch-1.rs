#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(twiceappearance("acbddbca"), 'd');
}

#[test]
fn test_ex2() {
    assert_eq!(twiceappearance("abccd"), 'c');
}

#[test]
fn test_ex3() {
    assert_eq!(twiceappearance("abcdabbb"), 'a');
}

fn twiceappearance(a: &str) -> char {
    let mut m = HashSet::new();
    for c in a.chars() {
        if m.contains(&c) {
            return c;
        }
        m.insert(c);
    }
    'x'
}
