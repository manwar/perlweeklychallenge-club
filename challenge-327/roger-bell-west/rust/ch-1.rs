#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(missingintegers(vec![1, 2, 1, 3, 2, 5]), vec![4, 6]);
}

#[test]
fn test_ex2() {
    assert_eq!(missingintegers(vec![1, 1, 1]), vec![2, 3]);
}

#[test]
fn test_ex3() {
    assert_eq!(missingintegers(vec![2, 2, 1]), vec![3]);
}

#[test]
fn test_ex4() {
    assert_eq!(missingintegers(vec![2, 1]), Vec::<i32>::new());
}

fn missingintegers(a: Vec<i32>) -> Vec<i32> {
    let range = (1..=a.len() as i32).collect::<HashSet<i32>>();
    let present = a.into_iter().collect::<HashSet<i32>>();
    let mut b = range.difference(&present).copied().collect::<Vec<i32>>();
    b.sort_unstable();
    b
}
