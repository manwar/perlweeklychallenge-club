#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(
        cuban1(1000),
        vec![7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919]
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

fn cuban1(mx: usize) -> Vec<usize> {
    let mut o: Vec<usize> = Vec::new();
    let ps: HashSet<usize> = HashSet::from_iter(genprimes(mx));
    for y in 1..mx + 1 {
        let q = 3 * y * (y + 1) + 1;
        if q > mx {
            break;
        }
        if ps.contains(&q) {
            o.push(q);
        }
    }
    o
}
