#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(kaprekarconstant(3524), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(kaprekarconstant(6174), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(kaprekarconstant(9998), 5);
}

#[test]
fn test_ex4() {
    assert_eq!(kaprekarconstant(1001), 4);
}

#[test]
fn test_ex5() {
    assert_eq!(kaprekarconstant(9000), 4);
}

#[test]
fn test_ex6() {
    assert_eq!(kaprekarconstant(1111), -1);
}

fn a2n(a: &Vec<u32>) -> u32 {
    let mut t = 0;
    for d in a {
        t *= 10;
        t += d;
    }
    t
}

fn kaprekarconstant(a: u32) -> i32 {
    let mut ct: i32 = 0;
    let mut b = a;
    while b != 6174 {
        if b == 0 {
            return -1;
        }
        let mut digits = Vec::new();
        for _ in 0..=3 {
            digits.push(b % 10);
            b /= 10;
        }
        digits.sort();
        let mut stigid = digits.clone();
        stigid.reverse();
        b = a2n(&stigid) - a2n(&digits);
        ct += 1;
    }
    ct
}
