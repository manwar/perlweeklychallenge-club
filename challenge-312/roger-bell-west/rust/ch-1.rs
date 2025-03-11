#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(minimumtime("abc"), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(minimumtime("bza"), 7);
}

#[test]
fn test_ex3() {
    assert_eq!(minimumtime("zjpc"), 34);
}

fn transfer(a: char, b: char) -> u32 {
    let ac = a as i8;
    let bc = b as i8;
    std::cmp::min((ac - bc + 26) % 26, (bc - ac + 26) % 26) as u32
}

fn minimumtime(a: &str) -> u32 {
    let mut tot = a.len() as u32;
    let mut prev = 'a';
    for c in a.chars() {
        tot += transfer(prev, c);
        prev = c
    }
    tot 
}
