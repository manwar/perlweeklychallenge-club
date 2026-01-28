#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(encryptedstring("abc", 1), "bcd");
}

#[test]
fn test_ex2() {
    assert_eq!(encryptedstring("xyz", 2), "zab");
}

#[test]
fn test_ex3() {
    assert_eq!(encryptedstring("abc", 27), "bcd");
}

#[test]
fn test_ex4() {
    assert_eq!(encryptedstring("hello", 5), "mjqqt");
}

#[test]
fn test_ex5() {
    assert_eq!(encryptedstring("perl", 26), "perl");
}

fn rotx(a: char, offset: i32) -> char {
    let o = offset.rem_euclid(26) as i8;
    let base;
    match a {
        'a'..='z' => {
            base = 'a' as i8;
        }
        'A'..='Z' => {
            base = 'A' as i8;
        }
        _ => {
            return a;
        }
    };
    let c = (a as i8 - base + o).rem_euclid(26) + base;
    c as u8 as char
}

fn encryptedstring(a: &str, offset: i32) -> String {
    a.chars().map(|x| rotx(x, offset)).collect::<String>()
}
