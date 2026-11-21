#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(largestinterval(20), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(largestinterval(110), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(largestinterval(500), 11);
}

#[test]
fn test_ex4() {
    assert_eq!(largestinterval(2026), 105);
}

#[test]
fn test_ex5() {
    assert_eq!(largestinterval(10000), 105);
}

use std::collections::HashSet;

fn hasrepeateddigits(a: u64) -> bool {
    let mut cs = HashSet::new();
    for c in a.to_string().chars() {
        if cs.contains(&c) {
            return true;
        }
        cs.insert(c);
    }
    false
}

fn largestinterval(a: u64) -> u64 {
    let v = (1..=a).filter(|x| !hasrepeateddigits(*x)).collect::<Vec<_>>();
    v.windows(2).map(|x| x[1] - x[0]).max().unwrap()
}
