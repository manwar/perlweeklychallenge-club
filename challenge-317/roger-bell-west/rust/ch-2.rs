#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(friendlystrings("desc", "dsec"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(friendlystrings("fuck", "fcuk"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(friendlystrings("poo", "eop"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(friendlystrings("stripe", "sprite"), true);
}

fn friendlystrings(a: &str, b: &str) -> bool {
    let aa = a.chars().collect::<Vec<_>>();
    let bb = b.chars().collect::<Vec<_>>();
    for i in 0..aa.len() - 1 {
        for j in i + 1..aa.len() {
            let mut cc = aa.clone();
            (cc[i], cc[j]) = (cc[j], cc[i]);
            if cc == bb {
                return true;
            }
        }
    }
    false
}
