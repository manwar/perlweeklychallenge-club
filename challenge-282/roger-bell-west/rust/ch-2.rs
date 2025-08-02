#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(changingkeys("pPeERrLl"), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(changingkeys("rRr"), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(changingkeys("GoO"), 1);
}

fn changingkeys(a: &str) -> u32 {
    let mut oc = 'x';
    let mut out = 0;
    for (i, c) in a.to_ascii_lowercase().chars().enumerate() {
        if i == 0 {
            oc = c;
        } else if c != oc {
            oc = c;
            out += 1;
        }
    }
    out
}
