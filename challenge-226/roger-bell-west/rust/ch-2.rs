#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(zeroarray(vec![1, 5, 0, 3, 5]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(zeroarray(vec![0]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(zeroarray(vec![2, 1, 4, 0, 3]), 4);
}

fn zeroarray(a: Vec<usize>) -> usize {
    let mut s: HashSet<usize> = HashSet::new();
    for n in a {
        s.insert(n);
    }
    s.remove(&0);
    s.len()
}
