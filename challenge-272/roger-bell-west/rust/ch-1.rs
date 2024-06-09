#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(defrangip("1.1.1.1"), "1[.]1[.]1[.]1");
}

#[test]
fn test_ex2() {
    assert_eq!(defrangip("255.101.1.0"), "255[.]101[.]1[.]0");
}

fn defrangip(a: &str) -> String {
    let mut out = String::new();
    for c in a.chars() {
        if c == '.' {
            out.push_str("[.]");
        } else {
            out.push(c);
        }
    }
    out
}
