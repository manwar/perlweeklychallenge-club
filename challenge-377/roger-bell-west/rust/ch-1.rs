#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(reverseexistence("abcba"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(reverseexistence("racecar"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(reverseexistence("abcd"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(reverseexistence("banana"), true);
}

#[test]
fn test_ex5() {
    assert_eq!(reverseexistence("hello"), true);
}

fn reverseexistence(a: &str) -> bool {
    let c = a.chars().rev().collect::<Vec<_>>();
    for d in c.windows(2) {
        let mut sample = String::new();
        sample.push(d[0]);
        sample.push(d[1]);
        if let Some(_) = a.find(&sample) {
            return true;
        }
    }
    false
}
