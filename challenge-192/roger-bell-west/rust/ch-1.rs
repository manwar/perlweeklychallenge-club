#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(binaryflip(5), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(binaryflip(4), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(binaryflip(6), 1);
}

fn binaryflip(n: usize) -> usize {
    let mut m = n;
    let mut r = 0;
    while m > 0 {
        m >>= 1;
        r += 1;
    }
    (1 << r) - 1 - n
}
