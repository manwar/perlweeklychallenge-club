#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(buddystrings("fuck", "fcuk"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(buddystrings("love", "love"), false);
}

#[test]
fn test_ex3() {
    assert_eq!(buddystrings("fodo", "food"), true);
}

#[test]
fn test_ex4() {
    assert_eq!(buddystrings("feed", "feed"), true);
}

fn buddystrings(a: &str, b: &str) -> bool {
    let ac = a.chars().collect::<Vec<_>>();
    let bc = b.chars().collect::<Vec<_>>();
    for i in 0 .. ac.len() - 1 {
        for j in i + 1 .. ac.len() {
            let mut acx = ac.clone();
            acx[i] = ac[j];
            acx[j] = ac[i];
            if acx == bc {
                return true;
            }
        }
    }
    false
}
