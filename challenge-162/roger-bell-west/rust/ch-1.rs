#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(generate("978-0-306-40615-"), 7);
}

#[test]
fn test_ex2() {
    assert_eq!(generate("978-0-306-40615-7"), 7);
}

#[test]
fn test_ex3() {
    assert_eq!(validate("978-0-306-40615-7"), true);
}

#[test]
fn test_ex4() {
    assert_eq!(validate("978-0-306-46015-7"), false);
}

fn generate(in0: &str) -> u32 {
    let mut s = 0;
    let mut m = 1;
    let mut l = 0;
    for c in in0.chars() {
        if let Some(i) = c.to_digit(10) {
            s += m * i;
            m = 4 - m;
            l += 1;
            if l >= 12 {
                break;
            }
        }
    }
    if l < 12 {
        return 99;
    }
    (10 - (s % 10)) % 10
}

fn validate(in0: &str) -> bool {
    let mut in1: String = String::new();
    for c in in0.chars() {
        if let Some(_i) = c.to_digit(10) {
            in1.push(c)
        }
    }
    if in1.len() != 13 {
        return false;
    }
    generate(&in1) == in1.chars().nth(12).unwrap().to_digit(10).unwrap()
}
