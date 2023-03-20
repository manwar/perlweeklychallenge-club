#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(minindexsum(vec!["Perl", "Raku", "Love"], vec!["Raku", "Perl", "Hate"]), vec!["Perl", "Raku"]);
}

#[test]
fn test_ex2() {
    assert_eq!(minindexsum(vec!["A", "B", "C"], vec!["D", "E", "F"]), Vec::<String>::new());
}

#[test]
fn test_ex3() {
    assert_eq!(minindexsum(vec!["A", "B", "C"], vec!["C", "A", "B"]), vec!["A"]);
}

fn v2hm(a: Vec<&str>) -> HashMap<&str, usize> {
    let mut h: HashMap<&str, usize> = HashMap::new();
    for (i, x) in a.iter().enumerate() {
        if !h.contains_key(x) {
            h.insert(x, i);
        }
    }
    h
}

fn minindexsum(a: Vec<&str>, b: Vec<&str>) -> Vec<String> {
    let ah = v2hm(a);
    let bh = v2hm(b);
    let mut out: Vec<String> = Vec::new();
    let mut mi = ah.len() + bh.len();
    for w in ah.keys() {
        if bh.contains_key(w) {
            let mv = ah.get(w).unwrap() + bh.get(w).unwrap();
            if mv < mi {
                out = Vec::new();
                mi = mv;
            }
            if mv == mi {
                out.push(w.to_string());
            }
        }
    }
    out.sort();
    return out;
}
 
