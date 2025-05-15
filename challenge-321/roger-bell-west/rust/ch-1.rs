#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(distinctaverage(vec![1, 2, 4, 3, 5, 6]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(distinctaverage(vec![0, 2, 4, 8, 3, 5]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(distinctaverage(vec![7, 3, 1, 0, 5, 9]), 2);
}

fn distinctaverage(a0: Vec<u32>) -> usize {
    let mut a = a0.clone();
    a.sort();
    let offset = a.len() - 1;
    let mut res = HashSet::new();
    for i in 0 .. a.len() / 2 {
        res.insert(a[i] + a[offset - i]);
    }
    res.len()
}
