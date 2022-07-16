#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(esthetic10(5456), true);
}

#[test]
fn test_ex2() {
    assert_eq!(esthetic10(120), false);
}

#[test]
fn test_ex3() {
    assert_eq!(esthetic10(12), true);
}

#[test]
fn test_ex4() {
    assert_eq!(esthetic10(5654), true);
}

#[test]
fn test_ex5() {
    assert_eq!(esthetic10(890), false);
}

fn esthetic10(n: i64) -> bool {
    esthetic(n, 10)
}

fn esthetic(n0: i64, base: i64) -> bool {
    let mut n = n0;
    let mut pdigit = 0;
    let mut ch = false;
    while n > 0 {
        let digit = n % base;
        if ch && (digit - pdigit).abs() != 1 {
            return false;
        }
        ch = true;
        pdigit = digit;
        n /= base
    }
    return true;
}
