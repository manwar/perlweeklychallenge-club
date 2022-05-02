#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sumbitwise(vec![1, 2, 3]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(sumbitwise(vec![2, 3, 4]), 2);
}

fn sumbitwise(ls: Vec<usize>) -> usize {
    let mut s = 0;
    for i in 0..ls.len() - 1 {
        for j in i + 1..ls.len() {
            s += ls[i] & ls[j];
        }
    }
    s
}
