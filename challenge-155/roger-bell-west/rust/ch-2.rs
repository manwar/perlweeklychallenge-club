#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(pisano(3), 8);
}

#[test]
fn test_ex2() {
    assert_eq!(pisano(6), 24);
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
    for p in [2, 3, 5, 7] {
        while m % p == 0 {
            m /= p;
            let en = f.entry(p).or_insert(0);
            *en += 1;
        }
    }
    if m > 1 {
        for p in genprimes(m).iter().skip(4) {
            while m % p == 0 {
                m /= p;
                let en = f.entry(*p).or_insert(0);
                *en += 1;
            }
            if m == 1 {
                break;
            }
        }
    }
    f
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

fn lcm(m: usize, n: usize) -> usize {
    m / gcd(m, n) * n
}

fn pow(x0: usize, pow0: usize) -> usize {
    let mut x = x0;
    let mut pow = pow0;
    let mut ret = 1;
    while pow > 0 {
        if (pow & 1) == 1 {
            ret *= x;
        }
        x *= x;
        pow >>= 1;
    }
    ret
}

fn pisano(n: usize) -> usize {
    let mut a = 1;
    for (k, v) in primefactor(n).iter() {
        let nn = pow(*k, *v);
        let mut t = 1;
        let mut x = [1, 1];
        while x != [0, 1] {
            t += 1;
            x = [x[1], (x[0] + x[1]) % nn];
        }
        a = lcm(a, t);
    }
    a
}
