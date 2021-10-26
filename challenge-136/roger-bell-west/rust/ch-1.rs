#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(twofriendly(8,24),1);
}

#[test]
fn test_ex2() {
    assert_eq!(twofriendly(26,39),0);
}

#[test]
fn test_ex3() {
    assert_eq!(twofriendly(4,10),1);
}

#[test]
fn test_ex4() {
    assert_eq!(twofriendly(1,2),0);
}

fn gcd(m: i32,n: i32) -> i32 {
    let mut mm=m;
    let mut nn=n;
    while nn!=0 {
        let t=mm;
        mm=nn;
        nn=t%nn;
    }
    mm
}

fn ispower2(n: i32) -> bool {
    if n<2 {
        return false;
    }
    (n & (n-1))==0
}

fn twofriendly(m: i32, n: i32) -> u8 {
    if ispower2(gcd(m,n)) { 1 } else { 0 }
}
