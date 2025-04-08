#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(subsequence("uvw", "bcudvew"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(subsequence("aec", "abcde"), false);
}

#[test]
fn test_ex3() {
    assert_eq!(subsequence("sip", "javascript"), true);
}

fn subsequence(a: &str, b: &str) -> bool {
    let mut l = a;
    let mut s = b;
    if a.len() < b.len() {
        l = b;
        s = a;
    }
    let st = s.chars().collect::<Vec<char>>();
    let mut si = 0;
    for c in l.chars() {
        if c == st[si] {
            si += 1;
            if si >= st.len() {
                return true;
            }
        }
    }
    false
}
