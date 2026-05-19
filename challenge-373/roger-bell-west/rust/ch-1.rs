#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(equallist(vec!["a", "bc"], vec!["ab", "c"]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(equallist(vec!["a", "b", "c"], vec!["a", "bc"]), true);
}

#[test]
fn test_ex3() {
    assert_eq!(equallist(vec!["a", "bc"], vec!["a", "c", "b"]), false);
}

#[test]
fn test_ex4() {
    assert_eq!(equallist(vec!["ab", "c", ""], vec!["", "a", "bc"]), true);
}

#[test]
fn test_ex5() {
    assert_eq!(equallist(vec!["p", "e", "r", "l"], vec!["perl"]), true);
}

fn equallist(a: Vec<&str>, b: Vec<&str>) -> bool {
    a.join("") == b.join("")
}
