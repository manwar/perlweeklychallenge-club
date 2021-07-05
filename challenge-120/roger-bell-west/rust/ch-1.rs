#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(seob(101),154);
}

#[test]
fn test_ex2() {
    assert_eq!(seob(18),33);
}

fn seob (n: u8) -> u8 {
    return ((n & 0x55)<<1) | ((n & 0xAA)>>1);
}
