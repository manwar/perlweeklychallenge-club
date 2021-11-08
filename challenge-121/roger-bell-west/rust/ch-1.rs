#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(ib(12,3),8);
}

#[test]
fn test_ex2() {
    assert_eq!(ib(18,4),26);
}

fn ib (m: u8,n: u8) -> u8 {
    return m ^ (1 << (n-1))
}
