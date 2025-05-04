#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(minimumcommon(vec![1, 2, 3, 4], vec![3, 4, 5, 6]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(minimumcommon(vec![1, 2, 3], vec![2, 4]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(minimumcommon(vec![1, 2, 3, 4], vec![5, 6, 7, 8]), -1);
}

fn minimumcommon(a: Vec<usize>, b: Vec<usize>) -> isize {
    let aa = a.into_iter().collect::<HashSet<usize>>();
    let bb = b.into_iter().collect::<HashSet<usize>>();
    let cc = aa.intersection(&bb);
    if cc.clone().count() > 0 {
        *cc.min().unwrap() as isize
    } else {
        -1
    }
}
