#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(lastvisitor(vec![5, -1, -1]), vec![5, -1]);
}

#[test]
fn test_ex2() {
    assert_eq!(lastvisitor(vec![3, 7, -1, -1, -1]), vec![7, 3, -1]);
}

#[test]
fn test_ex3() {
    assert_eq!(lastvisitor(vec![2, -1, 4, -1, -1]), vec![2, 4, 2]);
}

#[test]
fn test_ex4() {
    assert_eq!(lastvisitor(vec![10, 20, -1, 30, -1, -1]), vec![20, 30, 20]);
}

#[test]
fn test_ex5() {
    assert_eq!(lastvisitor(vec![-1, -1, 5, -1]), vec![-1, -1, 5]);
}

use std::collections::VecDeque;

fn lastvisitor(a: Vec<i32>) -> Vec<i32> {
    let mut seen = VecDeque::new();
    let mut ans = Vec::new();
    let mut minusones = 0;
    for n in a {
        if n == -1 {
            minusones += 1;
            if minusones <= seen.len() {
                ans.push(seen[minusones - 1]);
            } else {
                ans.push(-1);
            }
        } else {
            seen.push_front(n);
            minusones = 0;
        }
    }
    ans
}
