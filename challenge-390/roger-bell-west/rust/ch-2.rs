#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(ordercharacters("dbca", 1), "adbc");
}

#[test]
fn test_ex2() {
    assert_eq!(ordercharacters("geeks", 2), "eegks");
}

#[test]
fn test_ex3() {
    assert_eq!(ordercharacters("cbaed", 3), "abcde");
}

#[test]
fn test_ex4() {
    assert_eq!(ordercharacters("fedcba", 4), "abcdef");
}

#[test]
fn test_ex5() {
    assert_eq!(ordercharacters("perl", 1), "erlp");
}

use std::collections::BTreeSet;

fn ordercharacters(a: &str, k: usize) -> String {
    let cc = a.chars().collect::<Vec<char>>();
    let mut stack = Vec::new();
    stack.push(cc.clone());
    let mut seen = BTreeSet::new();
    while let Some(s) = stack.pop() {
        for i in 0..k {
            let mut sp = s.clone();
            let c = sp.remove(i);
            sp.push(c);
            if !seen.contains(&sp) {
                seen.insert(sp.clone());
                stack.push(sp);
            }
        }
    }
    seen.into_iter().nth(0).unwrap().into_iter().collect()
}
