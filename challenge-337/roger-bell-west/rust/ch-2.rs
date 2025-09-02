#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(oddmatrix(2, 3, vec![vec![0, 1], vec![1, 1]]), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(oddmatrix(2, 2, vec![vec![1, 1], vec![0, 0]]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(oddmatrix(3, 3, vec![vec![0, 0], vec![1, 2], vec![2, 1]]), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(oddmatrix(1, 5, vec![vec![0, 2], vec![0, 4]]), 2);
}

#[test]
fn test_ex5() {
    assert_eq!(
        oddmatrix(4, 2, vec![vec![1, 0], vec![3, 1], vec![2, 0], vec![0, 1]]),
        8
    );
}

use std::collections::HashSet;

fn oddmatrix(rows: usize, cols: usize, points: Vec<Vec<usize>>) -> usize {
    let mut rm = HashSet::new();
    let mut cm = HashSet::new();
    for p in points {
        if rm.contains(&p[0]) {
            rm.remove(&p[0]);
        } else {
            rm.insert(p[0]);
        }
        if cm.contains(&p[1]) {
            cm.remove(&p[1]);
        } else {
            cm.insert(p[1]);
        }
    }
    rm.len() * (cols - cm.len()) + cm.len() * (rows - rm.len())
}
