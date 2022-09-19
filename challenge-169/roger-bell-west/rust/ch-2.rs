#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(
        achilles(20),
        vec![
            72, 108, 200, 288, 392, 432, 500, 648, 675, 800, 864, 968, 972,
            1125, 1152, 1323, 1352, 1372, 1568, 1800
        ]
    );
}

fn gcd(m0: usize, n0: usize) -> usize {
    let mut m = m0;
    let mut n = n0;
    while n != 0 {
        let t = n;
        n = m % n;
        m = t;
    }
    m
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

fn primefactor(n: usize) -> HashMap<usize, usize> {
    let mut f: HashMap<usize, usize> = HashMap::new();
    let mut m = n;
    for p in genprimes(1 + (n as f64).sqrt() as usize).iter() {
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

fn achilles(ct: usize) -> Vec<usize> {
    let mut o = Vec::new();
    let mut n = 1;
    loop {
        n += 1;
        let pv = primefactor(n).values().map(|i| *i).collect::<Vec<usize>>();
        if pv.len() > 1
            && pv.iter().min().unwrap() >= &2
            && pv.iter().fold(pv[0], |a, b| gcd(a, *b)) == 1
        {
            o.push(n);
            if o.len() >= ct {
                break;
            }
        }
    }
    o
}
