#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(frequencyequalizer("abbc"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(frequencyequalizer("xyzyyxz"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(frequencyequalizer("xzxz"), false);
}

fn frequencyequalizer(s: &str) -> bool {
    let mut f: HashMap<char, usize> = HashMap::new();
    for c in s.chars() {
        let en = f.entry(c).or_insert(0);
        *en += 1;
    }
    let mut v = f.into_values().collect::<Vec<usize>>();
    v.sort();
    if v[0] == v[v.len() - 2] && v[0] + 1 == v[v.len() - 1] {
        true
    } else {
        false
    }
}
