#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(basen(42, 2), "101010");
}

#[test]
fn test_ex2() {
    assert_eq!(basen(15642094, 16), "EEADEE");
}

#[test]
fn test_ex3() {
    assert_eq!(basen(493, 8), "755");
}

#[test]
fn test_ex4() {
    assert_eq!(basen(2228519, 36), "1BRJB");
}

#[test]
fn test_ex5() {
    assert_eq!(basen(123456789, 64), "7MyqL");
}

fn basen(a: u32, base: u32) -> String {
    if a == 0 {
        return "0".to_string();
    }
    let mut digits = Vec::new();
    for c in '0'..='9' {
        digits.push(c);
    }
    for c in 'A'..='Z' {
        digits.push(c);
    }
    for c in 'a'..='z' {
        digits.push(c);
    }
    digits.push('+');
    digits.push('/');
    let mut fields = Vec::new();
    let mut aa = a;
    while aa > 0 {
        fields.push(aa % base);
        aa /= base;
    }
    let mut output = String::new();
    while let Some(c) = fields.pop() {
        output.push(digits[c as usize]);
    }
    output
}
