#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(trimlist(vec![1, 4, 2, 3, 5], 3), vec![4, 5]);
}

#[test]
fn test_ex2() {
    assert_eq!(trimlist(vec![9, 0, 6, 2, 3, 8, 5], 4), vec![9, 6, 8, 5]);
}

fn trimlist(n: Vec<i64>, i: i64) -> Vec<i64> {
    n.into_iter().filter(|&x| x > i).collect::<Vec<i64>>()
}
