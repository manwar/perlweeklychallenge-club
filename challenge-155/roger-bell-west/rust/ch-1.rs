#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(fortunate(8), vec![3, 5, 7, 13, 17, 19, 23, 37]);
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

fn isprime(candidate: usize) -> bool {
    if candidate == 2 {
        return true;
    } else if candidate == 3 {
        return true;
    } else if candidate % 2 == 0 {
        return false;
    } else if candidate % 3 == 0 {
        return false;
    }
    let mut anchor = 0usize;
    let limit = (candidate as f64).sqrt() as usize;
    loop {
        anchor += 6;
        for t in [anchor - 1, anchor + 1].iter() {
            if *t > limit {
                return true;
            }
            if candidate % *t == 0 {
                return false;
            }
        }
    }
}

fn fortunate(ct: usize) -> Vec<usize> {
    let mut o: HashSet<usize> = HashSet::new();
    let mut ll: Vec<usize> = Vec::new();
    let mut ph = 1;
    for p in genprimes(nthprimelimit(ct * 2)) {
        if o.len() >= ct {
            if p >= *o.iter().max().unwrap() {
                break;
            }
        }
        ph *= p;
        let mut l = p + 1;
        while !isprime(l + ph) {
            l += 1;
        }
        o.insert(l);
        if o.len() > ct {
            ll = o.iter().map(|i| *i).collect();
            ll.sort();
            ll.truncate(ct);
            o = ll.clone().into_iter().collect();
        }
    }
    return ll;
}
