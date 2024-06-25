#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(replacedigits("a1c1e1"), "abcdef");
}

#[test]
fn test_ex2() {
    assert_eq!(replacedigits("a1b2c3d4"), "abbdcfdh");
}

#[test]
fn test_ex3() {
    assert_eq!(replacedigits("b2b"), "bdb");
}

#[test]
fn test_ex4() {
    assert_eq!(replacedigits("a16z"), "abgz");
}

fn replacedigits(a: &str) -> String {
    let mut out = String::new();
    let mut prev = 0;
    for c in a.chars() {
        out.push(match c {
            '0'..='9' => {
                char::from_u32(prev + c.to_digit(10).unwrap()).unwrap()
            }
            _ => {
                prev = c as u32;
                c
            }
        });
    }
    out
}
