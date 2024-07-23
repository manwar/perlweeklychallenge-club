#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(splitstring("perl"), false);
}

#[test]
fn test_ex2() {
    assert_eq!(splitstring("book"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(splitstring("goodmorning"), true);
}

fn splitstring(a: &str) -> bool {
    let mut n = 0;
    for cc in a.chars() {
        n += match cc.to_ascii_lowercase() {
            'a' | 'e' | 'i' | 'o' | 'u' => 1,
            _ => 0,
        }
    }
    n % 2 == 0
}
