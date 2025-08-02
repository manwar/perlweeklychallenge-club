#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(
        targetarray(vec![0, 1, 2, 3, 4], vec![0, 1, 2, 2, 1]),
        vec![0, 4, 1, 3, 2]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        targetarray(vec![1, 2, 3, 4, 0], vec![0, 1, 2, 3, 0]),
        vec![0, 1, 2, 3, 4]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(targetarray(vec![1], vec![0]), vec![1]);
}

fn targetarray(a: Vec<u32>, indices: Vec<usize>) -> Vec<u32> {
    let mut c: VecDeque<u32> = VecDeque::new();
    for (i, ix) in indices.into_iter().enumerate() {
        if ix == c.len() {
            c.push_back(a[i]);
        } else {
            c.insert(ix, a[i]);
        }
    }
    Vec::from(c)
}
