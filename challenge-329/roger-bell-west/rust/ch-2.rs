#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(nicestring("YaaAho"), "aaA");
}

#[test]
fn test_ex2() {
    assert_eq!(nicestring("Cc"), "Cc");
}

#[test]
fn test_ex3() {
    assert_eq!(nicestring("A"), "");
}

fn nicestring(a: &str) -> String {
    let c = a.chars().collect::<Vec<char>>();
    let l = c.len();
    for sl in (2..=l).rev() {
        for start in 0..=l - sl {
            let s = &c[start..start + sl];
            let mut lower = HashSet::new();
            let mut upper = HashSet::new();
            for ch in s {
                if ch.is_ascii_lowercase() {
                    lower.insert(ch.clone());
                } else if ch.is_ascii_uppercase() {
                    let mut cl = ch.clone();
                    cl.make_ascii_lowercase();
                    upper.insert(cl);
                }
            }
            if lower == upper {
                return s.into_iter().collect();
            }
        }
    }
    "".to_string()
}
