#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(upperlower("pERL"), "Perl");
}

#[test]
fn test_ex2() {
    assert_eq!(upperlower("rakU"), "RAKu");
}

#[test]
fn test_ex3() {
    assert_eq!(upperlower("PyThOn"), "pYtHoN");
}

fn upperlower(a: &str) -> String {
    let mut out = String::new();
    for c in a.chars() {
        out.push(char::from((c as u8) ^ 32));
    }
    out
}
