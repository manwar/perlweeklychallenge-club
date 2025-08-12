#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(rangesum(vec![-2, 0, 3, -5, 2, -1], 0, 2), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(rangesum(vec![1, -2, 3, -4, 5], 1, 3), -3);
}

#[test]
fn test_ex3() {
    assert_eq!(rangesum(vec![1, 0, 2, -1, 3], 3, 4), 2);
}

#[test]
fn test_ex4() {
    assert_eq!(rangesum(vec![-5, 4, -3, 2, -1, 0], 0, 3), -2);
}

#[test]
fn test_ex5() {
    assert_eq!(rangesum(vec![-1, 0, 2, -3, -2, 1], 0, 2), 1);
}

fn rangesum(a: Vec<i32>, s: usize, e: usize) -> i32 {
    a[s..=e].iter().sum()
}
