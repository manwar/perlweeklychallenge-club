#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(missingnumber(vec![0, 1, 3]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(missingnumber(vec![0, 1]), 2);
}


fn missingnumber(l: Vec<usize>) -> usize {
    let v: HashSet<&usize> = l.iter().collect();
    for i in 0..=l.len() {
        if !v.contains(&i) {
            return i;
        }
    }
    0
}
