#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(isqrt(10),3);
}

#[test]
fn test_ex2() {
    assert_eq!(isqrt(27),5);
}

#[test]
fn test_ex3() {
    assert_eq!(isqrt(85),9);
}

#[test]
fn test_ex4() {
    assert_eq!(isqrt(101),10);
}

fn isqrt(n: u32) -> u32 {
    let mut k=n >> 1;
    let mut x=true;
    while x {
        let k1=(k+n/k) >> 1;
        if k1 >= k {
            x=false;
        }
        k=k1;
    }
    k
}
