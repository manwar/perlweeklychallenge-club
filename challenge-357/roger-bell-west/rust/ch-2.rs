#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::BTreeSet;

#[test]
fn test_ex1() {
    assert_eq!(
        uniquefractiongenerator(3),
        vec!["1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        uniquefractiongenerator(4),
        vec![
            "1/4", "1/3", "1/2", "2/3", "3/4", "1/1", "4/3", "3/2", "2/1",
            "3/1", "4/1"
        ]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(uniquefractiongenerator(1), vec!["1/1"]);
}

#[test]
fn test_ex4() {
    assert_eq!(
        uniquefractiongenerator(6),
        vec![
            "1/6", "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4",
            "4/5", "5/6", "1/1", "6/5", "5/4", "4/3", "3/2", "5/3", "2/1",
            "5/2", "3/1", "4/1", "5/1", "6/1"
        ]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        uniquefractiongenerator(5),
        vec![
            "1/5", "1/4", "1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "4/5",
            "1/1", "5/4", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1",
            "5/1"
        ]
    );
}

fn gcd(m0: u32, n0: u32) -> u32 {
    let mut m = m0;
    let mut n = n0;
    while n != 0 {
        let t = n;
        n = m % n;
        m = t;
    }
    m
}

fn uniquefractiongenerator(a: u32) -> Vec<String> {
    let mut den = 1;
    for dn in 2..=a {
        den *= dn;
    }
    let mut f = BTreeSet::new();
    for d in 1..=a {
        let nd = den / d;
        for n in 1..=a {
            f.insert(n * nd);
        }
    }
    let mut out = Vec::new();
    for n in f.into_iter() {
        let g = gcd(n, den);
        let nn = n / g;
        let nd = den / g;
        out.push(format!("{}/{}", nn, nd));
    }
    out
}
