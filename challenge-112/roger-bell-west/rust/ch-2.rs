#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(cs(3),3);
}

#[test]
fn test_ex2() {
    assert_eq!(cs(4),5);
}

#[test]
fn test_ex3() {
    assert_eq!(cs(20),10946);
}

fn cs(i: u64) -> u64 {
    let mut a: u64=0;
    let mut b: u64=1;
    let mut c: u64=0;
    for _x in 0..i {
        c=a+b;
        a=b;
        b=c;
    }
    return c;
}
