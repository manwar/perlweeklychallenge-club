#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        binaryprefix(vec![0, 1, 1, 0, 0, 1, 0, 1, 1, 1]),
        vec![true, false, false, false, false, true, true, false, false, false]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        binaryprefix(vec![1, 0, 1, 0, 1, 0]),
        vec![false, false, true, true, false, false]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        binaryprefix(vec![0, 0, 1, 0, 1]),
        vec![true, true, false, false, true]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        binaryprefix(vec![1, 1, 1, 1, 1]),
        vec![false, false, false, true, false]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        binaryprefix(vec![1, 0, 1, 1, 0, 1, 0, 0, 1, 1]),
        vec![false, false, true, false, false, true, true, true, false, false]
    );
}

fn binaryprefix(a: Vec<u16>) -> Vec<bool> {
    let mut c = 0;
    let mut out = Vec::new();
    for n in a {
        c *= 2;
        c += n;
        out.push(c % 5 == 0);
    }
    out
}
