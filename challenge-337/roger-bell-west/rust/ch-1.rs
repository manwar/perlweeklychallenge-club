#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(smallerthancurrent(vec![6, 5, 4, 8]), vec![2, 1, 0, 3]);
}

#[test]
fn test_ex2() {
    assert_eq!(smallerthancurrent(vec![7, 7, 7, 7]), vec![0, 0, 0, 0]);
}

#[test]
fn test_ex3() {
    assert_eq!(smallerthancurrent(vec![5, 4, 3, 2, 1]), vec![4, 3, 2, 1, 0]);
}

#[test]
fn test_ex4() {
    assert_eq!(smallerthancurrent(vec![-1, 0, 3, -2, 1]), vec![1, 2, 4, 0, 3]);
}

#[test]
fn test_ex5() {
    assert_eq!(smallerthancurrent(vec![0, 1, 1, 2, 0]), vec![0, 2, 2, 4, 0]);
}

use std::collections::HashMap;

fn smallerthancurrent(a: Vec<i32>) -> Vec<usize> {
    let mut b = a.clone();
    b.sort();
    let mut m = HashMap::new();
    for (i, v) in b.into_iter().enumerate() {
        if !m.contains_key(&v) {
            m.insert(v, i);
        }
    }
    a.iter().map(|x| m.get(x).unwrap()).copied().collect::<Vec<_>>()
}
