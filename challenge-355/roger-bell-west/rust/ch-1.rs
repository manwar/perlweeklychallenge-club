#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(thousandseparator(123), "123");
}

#[test]
fn test_ex2() {
    assert_eq!(thousandseparator(1234), "1,234");
}

#[test]
fn test_ex3() {
    assert_eq!(thousandseparator(1000000), "1,000,000");
}

#[test]
fn test_ex4() {
    assert_eq!(thousandseparator(1), "1");
}

#[test]
fn test_ex5() {
    assert_eq!(thousandseparator(12345), "12,345");
}

fn thousandseparator(a: u32) -> String {
    let mut out = String::new();
    let s = a.to_string();
    let offset = 2 - ((s.len() + 2) % 3);
    for (i, d) in s.chars().enumerate() {
        if i > 0 && (i + offset).is_multiple_of(3) {
            out.push(',');
        }
        out.push(d);
    }
    out
}
