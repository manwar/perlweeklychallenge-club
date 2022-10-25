#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(totalzero(5, 4), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(totalzero(4, 6), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(totalzero(2, 5), 4);
}

#[test]
fn test_ex4() {
    assert_eq!(totalzero(3, 1), 3);
}

#[test]
fn test_ex5() {
    assert_eq!(totalzero(7, 4), 5);
}

fn totalzero(aa: usize, bb: usize) -> usize {
    if aa == 0 && bb == 0 {
        return 0;
    }
    let mut a = aa;
    let mut b = bb;
    let mut ct = 1;
    loop {
        if a == b {
            return ct;
        }
        ct += 1;
        if a > b {
            a -= b;
        } else {
            b -= a;
        }
    }
}
