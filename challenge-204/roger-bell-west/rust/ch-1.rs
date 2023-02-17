#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(monotonicarray(vec![1, 2, 2, 3]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(monotonicarray(vec![1, 3, 2]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(monotonicarray(vec![6, 5, 5, 4]), true);
}

fn monotonicarray(l: Vec<i32>) -> bool {
    let d = l.windows(2).map(|i| i[1] - i[0]);
    d.clone().max().unwrap() * d.min().unwrap() >= 0
}
