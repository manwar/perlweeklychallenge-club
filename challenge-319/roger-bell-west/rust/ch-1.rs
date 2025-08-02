#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(wordcount(vec!["unicode", "xml", "raku", "perl"]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(wordcount(vec!["the", "weekly", "challenge"]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(wordcount(vec!["perl", "python", "postgres"]), 0);
}

fn wordcount(a: Vec<&str>) -> usize {
    let mut ct = 0;
    for w in a {
        let mut c = w.chars();
        ct += match c.nth(0).unwrap() {
            'a' | 'e' | 'i' | 'o' | 'u' => 1,
            _ => match c.last().unwrap() {
                'a' | 'e' | 'i' | 'o' | 'u' => 1,
                _ => 0,
            },
        };
    }
    ct
}
