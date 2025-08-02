#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(circular(vec!["perl", "loves", "scala"]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(circular(vec!["love", "the", "programming"]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(circular(vec!["java", "awk", "kotlin", "node.js"]), true);
}

fn circular(a: Vec<&str>) -> bool {
    for p in a.windows(2) {
        if p[0].chars().last().unwrap() != p[1].chars().nth(0).unwrap() {
            return false;
        }
    }
    true
}
