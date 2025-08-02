#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(magicnumber(vec![3, 7, 5], vec![9, 5, 7]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(magicnumber(vec![1, 2, 1], vec![5, 4, 4]), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(magicnumber(vec![2], vec![5]), 3);
}

fn magicnumber(a: Vec<i32>, b: Vec<i32>) -> i32 {
    b.iter().min().unwrap() - a.iter().min().unwrap()
}
