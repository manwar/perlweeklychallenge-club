#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        splitstrings(vec!["one.two.three", "four.five", "six"], "."),
        vec!["one", "two", "three", "four", "five", "six"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        splitstrings(vec!["$perl$$", "$$raku$"], "$"),
        vec!["perl", "raku"]
    );
}

fn splitstrings(a: Vec<&str>, sep: &str) -> Vec<String> {
    let mut p = Vec::new();
    for s in a {
        let mut r = s
            .split(sep)
            .filter(|n| n.len() > 0)
            .map(|n| n.to_string())
            .collect::<Vec<_>>();
        p.append(&mut r);
    }
    p
}
