#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(rankarray(vec![55, 22, 44, 33]), vec![4, 1, 3, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(rankarray(vec![10, 10, 10]), vec![1, 1, 1]);
}

#[test]
fn test_ex3() {
    assert_eq!(rankarray(vec![5, 1, 1, 4, 3]), vec![4, 1, 1, 3, 2]);
}

fn rankarray(a: Vec<u32>) -> Vec<usize> {
    let mut b = a.clone();
    b.sort_unstable();
    b.dedup();
    let mut c = HashMap::new();
    for (i, n) in b.into_iter().enumerate() {
        c.insert(n, i + 1);
    }
    let mut out = Vec::new();
    for v in a {
        out.push(*c.get(&v).unwrap());
    }
    out
}
