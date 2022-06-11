#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(
        additiveprimes(100),
        vec![2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89]
    );
}

fn genprimes(mx: usize) -> Vec<usize> {
    let mut primesh: HashSet<usize> = HashSet::from_iter(2..=3);
    for i in (6..=mx).step_by(6) {
        for j in [i - 1, i + 1] {
            if j < mx {
                primesh.insert(j);
            }
        }
    }
    let mut q = VecDeque::from([2, 3, 5, 7]);
    let mut p = q.pop_front().unwrap();
    let mr = (mx as f64).sqrt() as usize;
    while p <= mr {
        if primesh.contains(&p) {
            for i in (p * p..=mx).step_by(p as usize) {
                primesh.remove(&i);
            }
        }
        if q.len() < 2 {
            let t = q[0] + 4;
            q.push_back(t);
            q.push_back(t + 2);
        }
        p = q.pop_front().unwrap();
    }
    let mut primes = primesh.iter().map(|i| *i).collect::<Vec<usize>>();
    primes.sort();
    primes
}

fn digitsum(x0: usize) -> usize {
    let mut s = 0;
    let mut x = x0;
    while x > 0 {
        s += x % 10;
        x /= 10;
    }
    return s;
}

fn additiveprimes(mx: usize) -> Vec<usize> {
    let mut o: Vec<usize> = Vec::new();
    let mut ps = HashSet::new();
    for q in genprimes(mx) {
        ps.insert(q);
        if ps.contains(&digitsum(q)) {
            o.push(q)
        }
    }
    o
}
