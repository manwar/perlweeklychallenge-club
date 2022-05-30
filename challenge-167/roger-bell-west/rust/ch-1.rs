#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(cyclicpermute(123), vec![231, 312, 123]);
}

#[test]
fn test_ex2() {
    assert_eq!(
        circular(3, 10),
        vec![113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933]
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

fn cyclicpermute(n: usize) -> Vec<usize> {
    let mut ss = n.to_string();
    let mut o = Vec::new();
    for _i in 0..ss.len() {
        ss = ss[1..].to_string() + &ss[0..1];
        o.push(ss.parse::<usize>().unwrap());
    }
    o
}

fn circular(mindigits: usize, ct: usize) -> Vec<usize> {
    let mut o = Vec::new();
    let mut base = 1;
    for _i in 1..mindigits {
        base *= 10;
    }
    while o.len() < ct {
        let pr = genprimes(base * 10);
        let mut prs: HashSet<usize> = HashSet::from_iter(pr.clone());
        for cp in pr {
            if cp >= base {
                let mut v = true;
                let cpp = cyclicpermute(cp);
                for cpc in &cpp {
                    if !prs.contains(cpc) {
                        v = false;
                        break;
                    }
                }
                if v {
                    o.push(cp);
                    if o.len() >= ct {
                        break;
                    }
                    for cpc in &cpp {
                        prs.remove(cpc);
                    }
                }
            }
        }
        base *= 10;
    }
    o
}
