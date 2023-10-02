#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(arithmeticsubsequence(vec![9, 4, 7, 2, 10]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(arithmeticsubsequence(vec![3, 6, 9, 12]), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(arithmeticsubsequence(vec![20, 1, 15, 3, 10, 5, 8]), 4);
}

fn isas(a: &Vec<i32>) -> bool {
    let t = a[1] - a[0];
    for i in a.iter().skip(1).collect::<Vec<&i32>>().windows(2) {
        if i[1] - i[0] != t {
            return false;
        }
    }
    true
}

fn arithmeticsubsequence(ints: Vec<i32>) -> i32 {
    let mut stack: VecDeque<Vec<i32>> = VecDeque::new();
    stack.push_back(ints);
    while stack.len() > 0 {
        let t = stack.pop_front().unwrap();
        if isas(&t) {
            return t.len() as i32;
        } else {
            for i in 0..t.len() {
                let mut tt = Vec::new();
                for ix in 0..t.len() {
                    if i != ix {
                        tt.push(t[ix]);
                    }
                }
                stack.push_back(tt);
            }
        }
    }
    0
}
