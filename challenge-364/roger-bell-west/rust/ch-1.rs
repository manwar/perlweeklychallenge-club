#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(decryptstring("10#11#12"), "jkab");
}

#[test]
fn test_ex2() {
    assert_eq!(decryptstring("1326#"), "acz");
}

#[test]
fn test_ex3() {
    assert_eq!(decryptstring("25#24#123"), "yxabc");
}

#[test]
fn test_ex4() {
    assert_eq!(decryptstring("20#5"), "te");
}

#[test]
fn test_ex5() {
    assert_eq!(decryptstring("1910#26#"), "aijz");
}

fn decryptstring(a: &str) -> String {
    let mut out = String::new();
    let c = a.chars().collect::<Vec<char>>();
    let mut s = 0;
    while s < c.len() {
        let mut m = c[s].to_digit(10).unwrap();
        if s + 2 < c.len() && c[s + 2] == '#' {
            m = m * 10 + c[s + 1].to_digit(10).unwrap();
            s += 2;
        }
        s += 1;
        out.push(char::from_u32(m + 96).unwrap());
    }
    out
}

