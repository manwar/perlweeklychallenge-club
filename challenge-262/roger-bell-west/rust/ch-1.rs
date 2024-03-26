#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::cmp::max;

#[test]
fn test_ex1() {
    assert_eq!(maxpositivenumber(vec![-3, 1, 2, -1, 3, -2, 4]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(maxpositivenumber(vec![-1, -2, -3, 1]), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(maxpositivenumber(vec![1, 2]), 2);
}

fn maxpositivenumber(a: Vec<i32>) -> u32 {
    max(
        a.iter().filter(|c| **c > 0).collect::<Vec<_>>().len(),
        a.iter().filter(|c| **c < 0).collect::<Vec<_>>().len(),
    ) as u32
}
