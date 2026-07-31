#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(similarlist(vec!["great", "acting"], vec!["fine", "drama"], vec![vec!["great", "fine"], vec!["acting", "drama"]]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(similarlist(vec!["apple", "pie"], vec!["banana", "pie"], vec![vec!["apple", "peach"], vec!["peach", "banana"]]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(similarlist(vec!["perl", "raku"], vec!["perl", "python"], Vec::new()), false);
}

#[test]
fn test_ex4() {
    assert_eq!(similarlist(vec!["enjoy", "challenge"], vec!["love", "weekly", "challenge"], vec![vec!["enjoy", "love"]]), false);
}

#[test]
fn test_ex5() {
    assert_eq!(similarlist(vec!["fast", "car"], vec!["quick", "vehicle"], vec![vec!["quick", "fast"], vec!["vehicle", "car"]]), true);
}

fn similarlist(a: Vec<&str>, b: Vec<&str>, similar: Vec<Vec<&str>>) -> bool {
    let mut simmap: HashMap<&str, &str> = HashMap::new();
    for simset in similar {
        let base = simset[0];
        for v in simset.into_iter().skip(1) {
            simmap.insert(v, base);
        }
    }
    for i in 0 .. a.len() {
        let aw = simmap.get(a[i]).unwrap_or(&a[i]);
        let bw = simmap.get(b[i]).unwrap_or(&b[i]);
        if aw != bw {
            return false;
        }
    }
    true
}
