#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sumofwords("acb", "cba", "cdb"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(sumofwords("aab", "aac", "ad"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(sumofwords("bc", "je", "jg"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(sumofwords("a", "aaaa", "aa"), true);
}

#[test]
fn test_ex5() {
    assert_eq!(sumofwords("c", "d", "h"), false);
}

#[test]
fn test_ex6() {
    assert_eq!(sumofwords("gfi", "hbf", "bdhd"), true);
}

fn l2n (a: &str) -> u32 {
    let a0 = 'a' as u32;
    let mut t = 0;
    for c in a.chars() {
        t *= 10;
        t += (c as u32) - a0;
    }
    t
}

fn sumofwords(a: &str, b: &str, c: &str) -> bool {
    l2n(a) + l2n(b) == l2n(c)
}
