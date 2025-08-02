#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::cmp::max;

#[test]
fn test_ex1() {
    assert_eq!(mergestrings("abcd", "1234"), "a1b2c3d4");
}

#[test]
fn test_ex2() {
    assert_eq!(mergestrings("abc", "12345"), "a1b2c345");
}

#[test]
fn test_ex3() {
    assert_eq!(mergestrings("abcde", "123"), "a1b2c3de");
}

fn mergestrings(a: &str, b: &str) -> String {
    let aa = a.chars().collect::<Vec<char>>();
    let bb = b.chars().collect::<Vec<char>>();
    let mut out: String = String::new();
    for i in 0 .. max(a.len(), b.len()) {
        if i < a.len() {
            out.push(aa[i]);
        }
        if i < b.len() {
            out.push(bb[i]);
        }
    }
    out
}
