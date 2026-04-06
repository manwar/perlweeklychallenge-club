#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maxoddbinary("1011"), "1101");
}

#[test]
fn test_ex2() {
    assert_eq!(maxoddbinary("100"), "001");
}

#[test]
fn test_ex3() {
    assert_eq!(maxoddbinary("111000"), "110001");
}

#[test]
fn test_ex4() {
    assert_eq!(maxoddbinary("0101"), "1001");
}

#[test]
fn test_ex5() {
    assert_eq!(maxoddbinary("1111"), "1111");
}

fn maxoddbinary(a: &str) -> String {
    let mut ones = 0;
    let mut zeroes = 0;
    for c in a.chars() {
        match c {
            '0' => {
                zeroes += 1;
            }
            '1' => {
                ones += 1;
            }
            _ => {}
        };
    }
    if ones < 1 {
        return String::new();
    }
    let mut out = String::new();
    for _ in 1..ones {
        out.push('1');
    }
    for _ in 0..zeroes {
        out.push('0');
    }
    out.push('1');
    out
}
