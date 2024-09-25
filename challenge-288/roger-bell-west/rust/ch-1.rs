#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(closestpalindrome("123"), "121");
}

#[test]
fn test_ex2() {
    assert_eq!(closestpalindrome("2"), "1");
}

#[test]
fn test_ex3() {
    assert_eq!(closestpalindrome("1400"), "1441");
}

#[test]
fn test_ex4() {
    assert_eq!(closestpalindrome("1000"), "999");
}

fn closestpalindrome(a: &str) -> String {
    let n = a.parse::<i32>().unwrap();
    let mut delta = -1;
    loop {
        let q = (n + delta).to_string();
        if q == q.chars().rev().collect::<String>() {
            return q;
        }
        delta = -delta;
        if delta < 0 {
            delta -= 1;
        }
    }
}
