#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(reversepairs(vec![1, 3, 2, 3, 1]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(reversepairs(vec![2, 4, 3, 5, 1]), 3);
}

fn reversepairs(a: Vec<u32>) -> u32 {
    a.iter().combinations(2).filter(|v| *v[0] > 2 * *v[1]).count() as u32
}
