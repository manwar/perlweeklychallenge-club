#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(nthprime(10001), 104743);
}

fn genprimes(mx: u32) -> Vec<u32> {
    let mut primesh: HashSet<u32> = HashSet::from_iter(2..=3);
    for i in (6..=mx).step_by(6) {
        for j in [i - 1, i + 1] {
            if j < mx {
                primesh.insert(j);
            }
        }
    }
    let mut q = VecDeque::from([2, 3, 5, 7]);
    let mut p = q.pop_front().unwrap();
    let mr = (mx as f64).sqrt() as u32;
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
    let mut primes = primesh.iter().map(|i| *i).collect::<Vec<u32>>();
    primes.sort();
    primes
}

fn nthprime(n: usize) -> u32 {
    let mut m = 15;
    if n >= 6 {
        let nn = n as f64;
        m = (1f64 + (nn.ln() * nn).ln() * nn) as u32;
    }
    let primes = genprimes(m);
    return primes[n - 1];
}
