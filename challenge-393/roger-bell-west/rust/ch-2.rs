#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(primestep("hello"), 9);
}

#[test]
fn test_ex2() {
    assert_eq!(primestep("football"), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(primestep("a"), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(primestep("challenge"), 2);
}

#[test]
fn test_ex5() {
    assert_eq!(primestep("perl"), 2);
}

use std::cmp::min;
use std::collections::{HashSet, VecDeque};
use std::iter::FromIterator;

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
    let mr = isqrt(mx);
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

fn isqrt(s: u32) -> u32 {
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

fn primestep(a: &str) -> u32 {
    let g = a.chars().map(|x| x as u32).sum::<u32>();
    let pm = genprimes(g * 2);
    let bs = pm.binary_search(&g);
    match bs {
        Ok(_) => 0,
        Err(ix) => min(g - pm[ix - 1], pm[ix] - g),
    }
}
