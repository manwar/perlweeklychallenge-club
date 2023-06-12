#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(commoncharacters(vec!["Perl", "Rust", "Raku"]), vec!['r']);
}

#[test]
fn test_ex2() {
    assert_eq!(
        commoncharacters(vec!["love", "live", "leave"]),
        vec!['e', 'l', 'v']
    );
}

fn word2set(word: &str) -> HashSet<char> {
    let mut s: HashSet<char> = HashSet::new();
    for c in word.to_ascii_lowercase().chars() {
        s.insert(c);
    }
    s
}

fn commoncharacters(lst: Vec<&str>) -> Vec<char> {
    let mut c = word2set(lst[0]);
    for w in lst.iter().skip(1) {
        c = c.intersection(&word2set(w)).cloned().collect::<HashSet<char>>();
    }
    let mut s = c.into_iter().collect::<Vec<_>>();
    s.sort();
    s
}
