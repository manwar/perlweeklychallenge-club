#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sn(101),86);
}

#[test]
fn test_ex2() {
    assert_eq!(sn(18),33);
}

fn sn (n: u8) -> u8 {
    return 16*(n % 16)+(n/16);
}
