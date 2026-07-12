#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(samerowcolumn(vec![vec![1, 2, 3, 4], vec![2, 3, 4, 1], vec![3, 4, 1, 2], vec![4, 1, 2, 3]]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(samerowcolumn(vec![vec![1]]), true);
}

#[test]
fn test_ex3() {
    assert_eq!(samerowcolumn(vec![vec![1, 2, 5], vec![5, 1, 2], vec![2, 5, 1]]), false);
}

#[test]
fn test_ex4() {
    assert_eq!(samerowcolumn(vec![vec![1, 2, 3], vec![1, 2, 3], vec![1, 2, 3]]), false);
}

#[test]
fn test_ex5() {
    assert_eq!(samerowcolumn(vec![vec![1, 2, 3], vec![3, 1, 2], vec![3, 2, 1]]), false);
}

fn samerowcolumn(a: Vec<Vec<usize>>) -> bool {
    for row in &a {
        let mut notfound = (1 ..= row.len()).collect::<HashSet<_>>();
        for n in row {
            notfound.remove(&n);
        }
        if notfound.len() > 0 {
            return false;
        }
    }
    for coln in 0 .. a[0].len() {
        let mut notfound = (1 ..= a.len()).collect::<HashSet<_>>();
        for row in &a {
            notfound.remove(&row[coln]);
        }
        if notfound.len() > 0 {
            return false;
        }
    }
    true
}
