#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(noconnection(vec![vec!['B', 'C'], vec!['D', 'B'], vec!['C', 'A']]), 'A');
}

#[test]
fn test_ex2() {
    assert_eq!(noconnection(vec![vec!['A', 'Z']]), 'Z');
}

fn noconnection(a: Vec<Vec<char>>) -> char {
    let os = a.iter().map(|x| x[0]).collect::<HashSet<_>>();
    let is = a.iter().map(|x| x[1]).collect::<HashSet<_>>();
    *is.difference(&os).collect::<Vec<_>>()[0]
}
