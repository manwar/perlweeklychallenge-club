#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(duplicateremovals("abbaca"), "ca");
}

#[test]
fn test_ex2() {
    assert_eq!(duplicateremovals("azxxzy"), "ay");
}

#[test]
fn test_ex3() {
    assert_eq!(duplicateremovals("aaaaaaaa"), "");
}

#[test]
fn test_ex4() {
    assert_eq!(duplicateremovals("aabccba"), "a");
}

#[test]
fn test_ex5() {
    assert_eq!(duplicateremovals("abcddcba"), "");
}

fn duplicateremovals(a: &str) -> String {
    let mut b = Vec::new();
    for c in a.chars() {
        if b.len() == 0 || c != b[b.len() - 1] {
            b.push(c);
        } else {
            b.pop();
        }
    }
    b.into_iter().collect()
}
