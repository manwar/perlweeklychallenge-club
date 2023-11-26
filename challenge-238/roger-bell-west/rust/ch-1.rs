#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(runningsum(vec![1, 2, 3, 4, 5]), vec![1, 3, 6, 10, 15]);
}

#[test]
fn test_ex2() {
    assert_eq!(runningsum(vec![1, 1, 1, 1, 1]), vec![1, 2, 3, 4, 5]);
}

#[test]
fn test_ex3() {
    assert_eq!(runningsum(vec![0, -1, 1, 2]), vec![0, -1, 0, 2]);
}

fn runningsum(a: Vec<i32>) -> Vec<i32> {
    let mut b = a.clone();
    for i in 1..b.len() {
        b[i] += b[i - 1];
    }
    b
}
