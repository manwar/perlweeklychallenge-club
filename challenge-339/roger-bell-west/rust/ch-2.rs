#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(peakpoint(vec![-5, 1, 5, -9, 2]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(peakpoint(vec![10, 10, 10, -25]), 30);
}

#[test]
fn test_ex3() {
    assert_eq!(peakpoint(vec![3, -4, 2, 5, -6, 1]), 6);
}

#[test]
fn test_ex4() {
    assert_eq!(peakpoint(vec![-1, -2, -3, -4]), 0);
}

#[test]
fn test_ex5() {
    assert_eq!(peakpoint(vec![-10, 15, 5]), 10);
}

fn peakpoint(a: Vec<i32>) -> i32 {
    let mut h = 0;
    let mut o = 0;
    for p in a {
        h += p;
        o = *[o, h].iter().max().unwrap();
    }
    o
}
