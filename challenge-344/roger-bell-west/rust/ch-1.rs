#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(arrayformcompute(vec![1, 2, 3, 4], 12), vec![1, 2, 4, 6]);
}

#[test]
fn test_ex2() {
    assert_eq!(arrayformcompute(vec![2, 7, 4], 181), vec![4, 5, 5]);
}

#[test]
fn test_ex3() {
    assert_eq!(arrayformcompute(vec![9, 9, 9], 1), vec![1, 0, 0, 0]);
}

#[test]
fn test_ex4() {
    assert_eq!(
        arrayformcompute(vec![1, 0, 0, 0, 0], 9999),
        vec![1, 9, 9, 9, 9]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(arrayformcompute(vec![0], 1000), vec![1, 0, 0, 0]);
}

fn u2a(a: u32) -> Vec<u32> {
    let mut p = a;
    if p > 0 {
        let mut out = Vec::new();
        while p > 0 {
            out.push(p % 10);
            p /= 10;
        }
        out.reverse();
        out
    } else {
        vec![0]
    }
}

fn a2u(a: Vec<u32>) -> u32 {
    let mut acc = 0;
    for d in a {
        acc *= 10;
        acc += d;
    }
    acc
}

fn arrayformcompute(a: Vec<u32>, b: u32) -> Vec<u32> {
    u2a(a2u(a) + b)
}
