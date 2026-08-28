#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(secretsanta(1), 0);
}

#[test]
fn test_ex2() {
    assert_eq!(secretsanta(2), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(secretsanta(3), 2);
}

#[test]
fn test_ex4() {
    assert_eq!(secretsanta(4), 9);
}

#[test]
fn test_ex5() {
    assert_eq!(secretsanta(5), 44);
}

fn secretsanta(n: u32) -> u32 {
    match n {
        0 => 1,
        1 => 0,
        _ => (n - 1) * (secretsanta(n - 1) + secretsanta(n - 2)),
    }
}
