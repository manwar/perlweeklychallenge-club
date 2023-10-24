#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(buildarray(vec![0, 2, 1, 5, 3, 4]), vec![0, 1, 2, 4, 5, 3]);
}

#[test]
fn test_ex2() {
    assert_eq!(buildarray(vec![5, 0, 1, 2, 3, 4]), vec![4, 5, 0, 1, 2, 3]);
}

fn buildarray(a: Vec<usize>) -> Vec<usize> {
    a.iter().map(|v| a[*v]).collect::<Vec<_>>()
}
