#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(rationalnumbers("0.(12)", "0.(121)"), false);
}

#[test]
fn test_ex2() {
    assert_eq!(rationalnumbers("0.1(23)", "0.12(32)"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(rationalnumbers("0.1(234)", "0.12(342)"), true);
}

#[test]
fn test_ex4() {
    assert_eq!(rationalnumbers("12.99(99)", "13."), true);
}

#[test]
fn test_ex5() {
    assert_eq!(rationalnumbers("0.(123)", "0.1(231)"), true);
}

use num::rational::Rational32;

fn pow(x0: u32, pow0: u32) -> u32 {
    let mut x = x0;
    let mut pow = pow0;
    let mut ret = 1;
    while pow > 0 {
        if (pow & 1) == 1 {
            ret *= x;
        }
        x *= x;
        pow >>= 1;
    }
    ret
}

fn str2rat(a: &str) -> Rational32 {
    let fixedpart;
    let repeatpart;
    if let Some(op) = a.find('(') {
        fixedpart = a.get(0..op).unwrap();
        repeatpart = a.get(op + 1..a.len() - 1).unwrap();
    } else {
        fixedpart = a;
        repeatpart = "0";
    }
    let point = fixedpart.find('.').unwrap();
    let tens = fixedpart.len() - point - 1;
    let n = fixedpart.get(0..point).unwrap().to_owned()
        + fixedpart.get(point + 1..).unwrap();
    let v =
        Rational32::new(n.parse::<i32>().unwrap(), pow(10, tens as u32) as i32);
    let repeatd = (pow(10, repeatpart.len() as u32) - 1) as i32;
    let w = Rational32::new(
        repeatpart.parse::<i32>().unwrap(),
        pow(10, tens as u32) as i32 * repeatd,
    );
    v + w
}

fn rationalnumbers(a: &str, b: &str) -> bool {
    str2rat(a) == str2rat(b)
}
