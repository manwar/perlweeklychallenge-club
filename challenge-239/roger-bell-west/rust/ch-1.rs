#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(samestring(vec!["ab", "c"], vec!["a", "bc"]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(samestring(vec!["ab", "c"], vec!["ac", "b"]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(samestring(vec!["ab", "cd", "e"], vec!["abcde"]), true);
}

fn samestring(a: Vec<&str>, b: Vec<&str>) -> bool {
    a.join("") == b.join("")
}
