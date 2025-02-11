#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(countcommon(vec!["perl", "weekly", "challenge"], vec!["raku", "weekly", "challenge"]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(countcommon(vec!["perl", "raku", "python"], vec!["python", "java"]), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(countcommon(vec!["guest", "contribution"], vec!["fun", "weekly", "challenge"]), 0);
}

fn countcommon(a: Vec<&str>, b: Vec<&str>) -> usize {
    let aa: HashSet<&str> = HashSet::from_iter(a.into_iter());
    let bb: HashSet<&str> = HashSet::from_iter(b.into_iter());
    aa.intersection(&bb).count()
}
