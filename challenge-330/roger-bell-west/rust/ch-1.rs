#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(cleardigits("cab12"), "c");
}

#[test]
fn test_ex2() {
    assert_eq!(cleardigits("xy99"), "");
}

#[test]
fn test_ex3() {
    assert_eq!(cleardigits("pa1erl"), "perl");
}

fn cleardigits(a: &str) -> String {
    let mut out = Vec::new();
    for c in a.chars().collect::<Vec<char>>() {
        if c.is_ascii_digit() {
            out.pop();
        } else {
            out.push(c);
        }
    }
    out.into_iter().collect()
}
