#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(multiplybytwo(vec![5, 3, 6, 1, 12], 3), 24);
}

#[test]
fn test_ex2() {
    assert_eq!(multiplybytwo(vec![1, 2, 4, 3], 1), 8);
}

#[test]
fn test_ex3() {
    assert_eq!(multiplybytwo(vec![5, 6, 7], 2), 2);
}

use std::collections::HashSet;
use std::iter::FromIterator;

fn multiplybytwo(a: Vec<u32>, start: u32) -> u32 {
    let p: HashSet<u32> = HashSet::from_iter(a);
    let mut v = start;
    while p.contains(&v) {
        v *= 2;
    }
    v
}
