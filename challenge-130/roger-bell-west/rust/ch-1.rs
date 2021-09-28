#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashSet;
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(on(vec![2,5,4,4,5,5,2]),5);
}

#[test]
fn test_ex2() {
    assert_eq!(on(vec![1,2,3,4,3,2,1,4,4]),4);
}

fn on(list: Vec<u64>) -> u64 {
    let mut k: HashSet<u64>=HashSet::new();
    for n in list {
        if k.contains(&n) {
            k.remove(&n);
        } else {
            k.insert(n);
        }
    }
    return Vec::from_iter(k)[0];
}
