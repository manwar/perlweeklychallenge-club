#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(
        completingword("aBc 11c", vec!["accbbb", "abc", "abbc"]),
        "accbbb"
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        completingword("La1 abc", vec!["abcl", "baacl", "abaalc"]),
        "baacl"
    );
}

#[test]
fn test_ex3() {
    assert_eq!(completingword("JB 007", vec!["jj", "bb", "bjb"]), "bjb");
}

fn str2hash(a: &str) -> HashMap<char, usize> {
    let mut m: HashMap<char, usize> = HashMap::new();
    for c in a.chars() {
        if c.is_alphabetic() {
            let lc = c.to_ascii_lowercase();
            let e = m.entry(lc).or_insert(0);
            *e += 1;
        }
    }
    m
}

fn completingword(a: &str, cw: Vec<&str>) -> String {
    let ah = str2hash(a);
    let mut out: Vec<&str> = Vec::new();
    for t in cw {
        let mut valid = true;
        let th = str2hash(t);
        for (k, v) in ah.iter() {
            if !th.contains_key(&k) {
                valid = false;
                break;
            }
            if th.get(k).unwrap() < v {
                valid = false;
                break;
            }
        }
        if valid {
            out.push(t)
        }
    }
    if out.len() == 0 {
        return "".to_string();
    }
    out.sort_by(|a, b| a.len().cmp(&b.len()));
    out[0].to_string()
}
