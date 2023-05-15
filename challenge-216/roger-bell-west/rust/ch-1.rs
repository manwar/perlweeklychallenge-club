#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        registrationnumber(vec!["abc", "abcd", "bcd"], "AB1 2CD"),
        vec!["abcd"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        registrationnumber(vec!["job", "james", "bjorg"], "007 JB"),
        vec!["job", "bjorg"]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        registrationnumber(vec!["crack", "road", "rac"], "C7 RA2"),
        vec!["crack", "rac"]
    );
}

fn word2set(word: &str) -> HashSet<char> {
    let mut s: HashSet<char> = HashSet::new();
    for c in word.to_ascii_lowercase().chars() {
        if c >= 'a' && c <= 'z' {
            s.insert(c);
        }
    }
    s
}

fn registrationnumber(words: Vec<&str>, reg: &str) -> Vec<String> {
    let s = word2set(reg);
    let mut out: Vec<String> = Vec::new();
    for w in words {
        let mut ss = s.clone();
        for c in word2set(w).iter() {
            if ss.contains(c) {
                ss.remove(c);
                if ss.len() == 0 {
                    out.push(w.to_string());
                    break;
                }
            }
        }
    }
    out
}
