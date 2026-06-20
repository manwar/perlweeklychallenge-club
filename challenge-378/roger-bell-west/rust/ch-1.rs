#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(secondlargestdigit("aaaaa77777"), -1);
}

#[test]
fn test_ex2() {
    assert_eq!(secondlargestdigit("abcde"), -1);
}

#[test]
fn test_ex3() {
    assert_eq!(secondlargestdigit("9zero8eight7seven9"), 8);
}

#[test]
fn test_ex4() {
    assert_eq!(secondlargestdigit("xyz9876543210"), 8);
}

#[test]
fn test_ex5() {
    assert_eq!(secondlargestdigit("4abc4def2ghi8jkl2"), 4);
}

fn secondlargestdigit(a: &str) -> i32 {
    let p = a.chars().filter(|x| *x >= '0' && *x <= '9').collect::<HashSet<_>>();
    let mut k = p.iter().collect::<Vec<_>>();
    k.sort_unstable();
    k.reverse();
    if k.len() > 1 {
        k[1].to_digit(10).unwrap() as i32
    } else {
        -1
    }
}
