#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(smallerthancurrent(vec![5, 2, 1, 6]), vec![2, 1, 0, 3]);
}

#[test]
fn test_ex2() {
    assert_eq!(smallerthancurrent(vec![1, 2, 0, 3]), vec![1, 2, 0, 3]);
}

#[test]
fn test_ex3() {
    assert_eq!(smallerthancurrent(vec![0, 1]), vec![0, 1]);
}

#[test]
fn test_ex4() {
    assert_eq!(smallerthancurrent(vec![9, 4, 9, 2]), vec![2, 1, 2, 0]);
}

use std::collections::HashMap;

fn smallerthancurrent(a: Vec<u32>) -> Vec<u32> {
    let mut s = a.clone();
    s.sort();
    let mut l: HashMap<u32, u32> = HashMap::new();
    for (i, n) in s.iter().enumerate() {
        if !l.contains_key(&n) {
            l.insert(*n, i as u32);
        }
    }
    a.into_iter().map(|n| l.get(&n).unwrap()).copied().collect::<Vec<u32>>()
}
