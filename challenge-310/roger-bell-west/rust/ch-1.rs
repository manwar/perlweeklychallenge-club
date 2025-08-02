#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(arraysintersection(vec![vec![1, 2, 3, 4], vec![4, 5, 6, 1], vec![4, 2, 1, 3]]), vec![1, 4]);
}

#[test]
fn test_ex2() {
    assert_eq!(arraysintersection(vec![vec![1, 0, 2, 3], vec![2, 4, 5]]), vec![2]);
}

#[test]
fn test_ex3() {
    assert_eq!(arraysintersection(vec![vec![1, 2, 3], vec![4, 5], vec![6]]), Vec::<u32>::new());
}

fn arraysintersection(a: Vec<Vec<u32>>) -> Vec<u32> {
    let mut s = a[0].clone().into_iter().collect::<HashSet<u32>>();
    for b in a.into_iter().skip(1) {
        let bs = b.into_iter().collect::<HashSet<u32>>();
        s = s.intersection(&bs).copied().collect();
    }
    let mut o = s.into_iter().collect::<Vec<u32>>();
    o.sort();
    o
}
