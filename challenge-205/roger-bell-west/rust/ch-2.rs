#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

// [dependencies]
// itertools = "0.10.5"

use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(maximumxor(vec![1, 2, 3, 4, 5, 6, 7]), 7);
}

#[test]
fn test_ex2() {
    assert_eq!(maximumxor(vec![2, 4, 1, 3]), 7);
}

#[test]
fn test_ex3() {
    assert_eq!(maximumxor(vec![10, 5, 7, 12, 8]), 15);
}


fn maximumxor(l: Vec<i32>) -> i32 {
    l.iter().combinations(2).map(|i| i[1] ^ i[0]).max().unwrap()
}
