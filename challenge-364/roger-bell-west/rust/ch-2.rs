#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(goalparser("G()(al)"), "Goal");
}

#[test]
fn test_ex2() {
    assert_eq!(goalparser("G()()()()(al)"), "Gooooal");
}

#[test]
fn test_ex3() {
    assert_eq!(goalparser("(al)G(al)()()"), "alGaloo");
}

#[test]
fn test_ex4() {
    assert_eq!(goalparser("()G()G"), "oGoG");
}

#[test]
fn test_ex5() {
    assert_eq!(goalparser("(al)(al)G()()"), "alalGoo");
}

fn goalparser(a: &str) -> String {
    let mut out = String::new();
    let mut s = 0;
    while s < a.len() {
        if a[s..].starts_with("G") {
            s += 1;
            out.push('G');
        } else if a[s..].starts_with("()") {
            s += 2;
            out.push('o');
        } else if a[s..].starts_with("(al)") {
            s += 4;
            out.push_str("al");
        } else {
            return "".to_string();
        }
    }
    out
}

