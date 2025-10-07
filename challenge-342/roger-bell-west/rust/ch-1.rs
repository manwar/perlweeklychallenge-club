#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(balancestring("a0b1c2"), "0a1b2c");
}

#[test]
fn test_ex2() {
    assert_eq!(balancestring("abc12"), "a1b2c");
}

#[test]
fn test_ex3() {
    assert_eq!(balancestring("0a1b2c3"), "0a1b2c3");
}

#[test]
fn test_ex4() {
    assert_eq!(balancestring("1a23"), "");
}

#[test]
fn test_ex5() {
    assert_eq!(balancestring("ab123"), "1a2b3");
}

fn balancestring(a: &str) -> String {
    let mut letters = Vec::new();
    let mut digits = Vec::new();
    for c in a.chars() {
        match c {
            'a'..='z' => letters.push(c),
            '0'..='9' => digits.push(c),
            _ => (),
        };
    }
    if digits.len() > letters.len() + 1 || letters.len() > digits.len() + 1 {
        return "".to_string();
            }
    digits.sort_unstable();
    letters.sort_unstable();
    let mut a = digits.clone();
    let mut b = letters.clone();
    if letters.len() == digits.len() + 1 {
        a = letters;
        b = digits;
    }
    let mut out = String::new();
    for i in 0..b.len() {
        out.push(a[i]);
        out.push(b[i]);
    }
    if a.len() > b.len() {
        out.push(a[a.len() - 1]);
    }
    out
}
