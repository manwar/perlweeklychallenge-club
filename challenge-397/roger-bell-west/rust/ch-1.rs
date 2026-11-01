#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(absentsmallestpositive(vec![1, 2, 4, 5, 6]), 7);
}

#[test]
fn test_ex2() {
    assert_eq!(absentsmallestpositive(vec![-5, -2, -1, 3]), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(absentsmallestpositive(vec![1, 2, 3]), 4);
}

#[test]
fn test_ex4() {
    assert_eq!(absentsmallestpositive(vec![2, 3, 7, 8]), 6);
}

#[test]
fn test_ex5() {
    assert_eq!(absentsmallestpositive(vec![1, 1, 1, 10]), 4);
}

use std::collections::HashSet;

fn absentsmallestpositive(a: Vec<i32>) -> i32 {
    let tot = a.iter().sum();
    let ex = a.iter().collect::<HashSet<_>>();
    let mul = a.len() as i32;
    for n in 1i32.. {
        if n * mul > tot && !ex.contains(&n) {
            return n;
        }
    }
    0
}
