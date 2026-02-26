#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(echochamber("abca"), "abbcccaaaa");
}

#[test]
fn test_ex2() {
    assert_eq!(echochamber("xyz"), "xyyzzz");
}

#[test]
fn test_ex3() {
    assert_eq!(echochamber("code"), "coodddeeee");
}

#[test]
fn test_ex4() {
    assert_eq!(echochamber("hello"), "heelllllllooooo");
}

#[test]
fn test_ex5() {
    assert_eq!(echochamber("a"), "a");
}

fn echochamber(a: &str) -> String {
    let mut out = String::new();
    for (i, c) in a.chars().enumerate() {
        for _ in 0..i + 1 {
            out.push(c);
        }
    }
    out
}
