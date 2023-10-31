#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(primeorder(vec![11, 8, 27, 4]), vec![11, 4, 8, 27]);
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

fn isqrt(s: usize) -> usize {
    if s <= 1 {
        return s;
    }
    let mut x0 = s / 2;
    let mut x1 = (x0 + s / x0) / 2;
    while x1 < x0 {
	x0 = x1;
	x1 = (x0 + s / x0) / 2;
    }		
    return x0;
}

fn primefactor(n: usize) -> HashMap<usize, usize> {
    let mut f: HashMap<usize, usize> = HashMap::new();
    let mut m = n;
    for p in genprimes(1 + isqrt(n)).iter() {
        while m % p == 0 {
            m /= p;
            let en = f.entry(*p).or_insert(0);
            *en += 1;
        }
        if m == 1 {
            break;
        }
    }
    if m > 1 {
        let en = f.entry(m).or_insert(0);
        *en += 1;
    }
    f
}

fn primefactorcount(n: usize) -> usize {
    primefactor(n).values().sum()
}

fn primeorder(ints: Vec<usize>) -> Vec<usize> {
    let mut b = ints;
    b.sort();
    b.sort_by_cached_key(|i| primefactorcount(*i));
    b
}
