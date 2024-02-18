#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(maximumpairs(vec!["ab", "de", "ed", "bc"]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(maximumpairs(vec!["aa", "ba", "cd", "ed"]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(maximumpairs(vec!["uv", "qp", "st", "vu", "mn", "pq"]), 2);
}

fn maximumpairs(a: Vec<&str>) -> u32 {
    let mut n = 0;
    let mut r: HashSet<String> = HashSet::new();
    for s in a {
        let t = s.chars().rev().collect::<String>();
        if r.contains(&t) {
            n += 1;
        } else {
            r.insert(s.to_string());
        }
    }
    n
}
