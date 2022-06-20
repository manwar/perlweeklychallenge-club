#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(primorial(5), vec![1, 2, 6, 30, 210]);
}

#[test]
fn test_ex2() {
    assert_eq!(
        primorial(10),
        vec![1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870]
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

fn nthprimelimit(n: usize) -> usize {
    let mut m = 15;
    if n >= 6 {
        let nn = n as f64;
        m = (1f64 + (nn.ln() * nn).ln() * nn) as usize;
    }
    m
}

fn primorial(ct: usize) -> Vec<usize> {
    let mut o = vec![1];
    for p in genprimes(nthprimelimit(ct-1)) {
        o.push(o.last().unwrap() * p);
        if o.len() >= ct {
            break;
        }
    }
    o
}
