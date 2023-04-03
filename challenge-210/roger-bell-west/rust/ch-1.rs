#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(killandwin(vec![2, 3, 1]), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(killandwin(vec![1, 1, 2, 2, 2, 3]), 11);
}

fn killandwin(a: Vec<u32>) -> u32 {
    a.iter().sum::<u32>()
}
