#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(dld(24, 2), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(dld(30, 5), 2);
}

fn factor(n: u32) -> VecDeque<u32> {
    let mut ff = VecDeque::new();
    if n == 1 {
        ff.push_front(1);
        return ff;
    }
    let mut s = (n as f64).sqrt() as u32;
    if s * s == n {
        ff.push_back(s);
        s -= 1;
    }
    for pf in 2..=s {
        if n % pf == 0 {
            ff.push_front(pf);
            ff.push_back(n / pf);
        }
    }
    ff.push_front(1);
    ff.push_back(n);
    ff
}

fn dld(m: u32, n: u32) -> u32 {
    factor(m)
        .into_iter()
        .filter(|i| i % 10 == n)
        .collect::<Vec<u32>>()
        .len() as u32
}
