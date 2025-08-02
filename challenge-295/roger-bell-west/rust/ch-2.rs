#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::cmp::min;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(jumpgame(vec![2, 3, 1, 1, 4]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(jumpgame(vec![2, 3, 0, 4]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(jumpgame(vec![2, 0, 0, 4]), -1);
}

fn jumpgame(a: Vec<usize>) -> isize {
    let target = a.len() - 1;
    let mut here: HashSet<usize> = HashSet::new();
    here.insert(0);
    let mut moves = 0;
    loop {
        moves += 1;
        let mut there: HashSet<usize> = HashSet::new();
        for n in here {
            for i in n + 1..=min(n + a[n], target) {
                there.insert(i);
            }
        }
        if there.is_empty() {
            return -1;
        }
        if there.contains(&target) {
            return moves;
        }
        here = there;
    }
}
