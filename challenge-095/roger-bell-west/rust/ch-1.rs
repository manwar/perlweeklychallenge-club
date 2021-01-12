#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(pn(1221),1)
}

#[test]
fn test_ex2() {
    assert_eq!(pn(-101),0)
}

#[test]
fn test_ex3() {
    assert_eq!(pn(90),0)
}

fn pn(n: i64) -> u8 {
    let ns=n.to_string();
    let nr: String=ns.chars().rev().collect();
    if nr == ns {
        return 1;
    } else {
        return 0;
    }
}
