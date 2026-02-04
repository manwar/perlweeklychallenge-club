#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(digitalroot(38), vec![2, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(digitalroot(7), vec![0, 7]);
}

#[test]
fn test_ex3() {
    assert_eq!(digitalroot(999), vec![2, 9]);
}

#[test]
fn test_ex4() {
    assert_eq!(digitalroot(1999999999), vec![3, 1]);
}

#[test]
fn test_ex5() {
    assert_eq!(digitalroot(101010), vec![1, 3]);
}

fn digitalroot(a: u32) -> Vec<u32> {
    let mut count = 0;
    let mut value = a;
    while value > 9 {
        let mut p = 0;
        while value > 0 {
            p += value % 10;
            value /= 10;
        }
        value = p;
        count += 1;
    }
    vec![count, value]
}
