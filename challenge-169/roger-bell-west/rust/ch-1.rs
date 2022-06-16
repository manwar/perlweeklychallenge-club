#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(
        brilliant(20),
        vec![
            4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221,
            247, 253, 289, 299
        ]
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

fn brilliant(ct: usize) -> Vec<usize> {
    let mut base = 1;
    let mut out: HashSet<usize> = HashSet::new();
    loop {
        let pl = genprimes(base * 10)
            .iter()
            .filter(|i| **i >= base)
            .map(|i| *i)
            .collect::<Vec<usize>>();
        for ai in 0..pl.len() {
            for bi in ai..pl.len() {
                out.insert(pl[ai] * pl[bi]);
            }
        }
        if out.len() >= ct {
            break;
        }
        base *= 10;
    }
    let mut o = out.iter().map(|i| *i).collect::<Vec<usize>>();
    o.sort();
    o.resize(ct, 0);
    o
}
