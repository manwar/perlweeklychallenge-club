#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

#[test]
fn text_ex1() {
    assert_eq!(primepartition(18, 2), vec![13, 5]);
}

#[test]
fn text_ex2() {
    assert_eq!(primepartition(19, 3), vec![11, 5, 3]);
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

fn primepartition(n: usize, divs: usize) -> Vec<usize> {
    let pl = genprimes(n as usize);
    let mut p = vec![Vec::new()];
    while p.len() > 0 {
        let pa = p.pop().unwrap();
        if pa.len() == divs {
            if pa.iter().sum::<usize>() == n {
                return pa;
            }
        } else {
            let px: HashSet<usize> = HashSet::from_iter(pa.clone());
            for pq in &pl {
                if !px.contains(&pq) {
                    let mut pb = pa.clone();
                    pb.push(*pq);
                    p.push(pb);
                }
            }
        }
    }
    vec![n]
}
