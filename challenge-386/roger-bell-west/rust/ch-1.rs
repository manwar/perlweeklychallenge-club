#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(reversebase("101010", 2), 42);
}

#[test]
fn test_ex2() {
    assert_eq!(reversebase("EEADEE", 16), 15642094);
}

#[test]
fn test_ex3() {
    assert_eq!(reversebase("755", 8), 493);
}

#[test]
fn test_ex4() {
    assert_eq!(reversebase("1BRJB", 36), 2228519);
}

#[test]
fn test_ex5() {
    assert_eq!(reversebase("7MyqL", 64), 123456789);
}

fn reversebase(a: &str, base: u32) -> u32 {
    let mut digits = Vec::new();
    for c in '0'..='9' {
        digits.push(c);
    }
    for c in 'A'..='Z' {
        digits.push(c);
    }
    for c in 'a'..='z' {
        digits.push(c);
    }
    digits.push('+');
    digits.push('/');
    let dd = digits
        .iter()
        .enumerate()
        .map(|(x, y)| (*y, x as u32))
        .collect::<HashMap<char, u32>>();
    let mut ov = 0;
    for c in a.chars() {
        ov *= base;
        ov += dd.get(&c).unwrap();
    }
    ov
}
