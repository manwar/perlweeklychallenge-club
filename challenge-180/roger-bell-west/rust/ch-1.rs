#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(firstunique("Perl Weekly Challenge"), 0);
}

#[test]
fn test_ex2() {
    assert_eq!(firstunique("Long Live Perl"), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(firstunique("aabbcc"), -1);
}

fn firstunique(s: &str) -> isize {
    let mut cc = HashMap::new();
    for c in s.chars() {
        let en = cc.entry(c).or_insert(0);
        *en += 1;
    }
    for (i, c) in s.chars().enumerate() {
        if cc.get(&c).unwrap() == &1 {
            return i as isize;
        }
    }
    -1
}
