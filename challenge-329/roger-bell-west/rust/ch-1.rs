#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(counterintegers("the1weekly2challenge2"), vec![1, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(counterintegers("go21od1lu5c7k"), vec![21, 1, 5, 7]);
}

#[test]
fn test_ex3() {
    assert_eq!(counterintegers("4p3e2r1l"), vec![4, 3, 2, 1]);
}

fn counterintegers(a: &str) -> Vec<u32> {
    let mut numbers = a
        .split(|x: char| !(x.is_numeric()))
        .filter(|x| *x != "")
        .map(|x| x.parse::<u32>().unwrap())
        .collect::<Vec<u32>>();
    let mut i = 0;
    let mut seen = HashSet::new();
    while i < numbers.len() {
        if seen.contains(&numbers[i]) {
            numbers.splice(i..=i, []);
        } else {
            seen.insert(numbers[i]);
            i += 1;
        }
    }
    numbers
}
