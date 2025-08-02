#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(uniquesumzero(5), vec![1, 2, 3, 4, -10]);
}

#[test]
fn test_ex2() {
    assert_eq!(uniquesumzero(3), vec![1, 2, -3]);
}

#[test]
fn test_ex3() {
    assert_eq!(uniquesumzero(1), vec![0]);
}

fn uniquesumzero(n: i32) -> Vec<i32> {
    if n == 1 {
        return vec![0];
    }
    let mut p = (1..n).collect::<Vec<i32>>();
    p.push(-n * (n - 1) / 2);
    p
}
