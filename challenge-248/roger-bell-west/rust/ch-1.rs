#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(shortestdistance("loveleetcode", 'e'), vec![3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0]);
}

#[test]
fn test_ex2() {
    assert_eq!(shortestdistance("aaab", 'b'), vec![3, 2, 1, 0]);
}

fn shortestdistance(a: &str, c: char) -> Vec<usize> {
    let mut q: VecDeque<(usize, usize)> = VecDeque::new();
    for (i, _c) in a.match_indices(c) {
        q.push_back((i, 0));
    }
    let invalid = a.len() + 1;
    let mut out: Vec<usize> = vec![invalid; a.len()];
    while q.len() > 0 {
        let (i, v) = q.pop_front().unwrap();
        if out[i] == invalid {
            out[i] = v;
            if i > 0 {
                q.push_back((i - 1, v + 1));
            }
            if i < a.len() - 1 {
                q.push_back((i + 1, v + 1));
            }
        }
    }
    out
}
