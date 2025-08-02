#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(findanagrams(vec!["acca", "dog", "god", "perl", "repl"]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(findanagrams(vec!["abba", "baba", "aabb", "ab", "ab"]), 2);
}

fn findanagrams(a: Vec<&str>) -> usize {
    let mut b: Vec<String> = Vec::new();
    for s in a {
        let mut c = s.chars().collect::<Vec<char>>();
        c.sort();
        b.push(c.iter().cloned().collect::<String>());
    }
    let mut out = 1;
    for s in b.windows(2) {
        if s[0] != s[1] {
            out += 1;
        }
    }
    out
}
