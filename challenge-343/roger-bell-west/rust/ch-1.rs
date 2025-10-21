#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(zerofriend(vec![4, 2, -1, 3, -2]), -1);
}

#[test]
fn test_ex2() {
    assert_eq!(zerofriend(vec![-5, 5, -3, 3, -1, 1]), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(zerofriend(vec![7, -3, 0, 2, -8]), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(zerofriend(vec![-2, -5, -1, -8]), -1);
}

#[test]
fn test_ex5() {
    assert_eq!(zerofriend(vec![-2, 2, -4, 4, -1, 1]), 1);
}

fn zerofriend(a: Vec<i32>) -> i32 {
    let b = a.iter().map(|x| x.abs()).min().unwrap();
    if a.iter().filter(|x| **x == b).count() > 0 {
        return b;
    }
    -b
}
