#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(convertpalindrome("pinnipeds"), "sdepinnipeds");
}

#[test]
fn test_ex2() {
    assert_eq!(convertpalindrome("abcd"), "dcbabcd");
}

#[test]
fn test_ex3() {
    assert_eq!(convertpalindrome("bananas"), "sananabananas");
}

#[test]
fn test_ex4() {
    assert_eq!(convertpalindrome("dissident"), "tnedissident");
}

#[test]
fn test_ex5() {
    assert_eq!(convertpalindrome("cailliachs"), "shcailliachs");
}


use std::collections::VecDeque;

fn is_palindrome(a: &VecDeque<char>) -> bool {
    let l = a.len();
    for i in 0 ..= l / 2 {
        if a[i] != a[l - i - 1] {
            return false;
        }
    }
    true
}

fn convertpalindrome(a: &str) -> String {
    let c0 = a.chars().collect::<VecDeque<char>>();
    let mut i = 0;
    loop {
        let mut c = c0.clone();
        for n in 0 .. i {
            c.push_front(c0[c0.len() - i + n]);
        }
        if is_palindrome(&c) {
            return c.iter().collect();
        }
        i += 1;
    }
}

