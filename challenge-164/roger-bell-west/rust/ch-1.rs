#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(
        primepal(1000),
        vec![
            2, 3, 5, 7, 11, 101, 131, 151, 181, 191, 313, 353, 373, 383, 727,
            757, 787, 797, 919, 929
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

fn isnumpal(c0: usize) -> bool {
    let mut c = c0;
    let mut j = 0;
    while c > 0 {
        j = 10 * j + c % 10;
        c /= 10;
    }
    c0 == j
}

fn primepal(pmax: usize) -> Vec<usize> {
    genprimes(pmax)
        .iter()
        .filter(|i| isnumpal(**i))
        .map(|i| *i)
        .collect::<Vec<usize>>()
}
