#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        prefixwords(vec!["pay", "attention", "practice", "attend"], "at"),
        2
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        prefixwords(vec!["janet", "julia", "java", "javascript"], "ja"),
        3
    );
}

fn prefixwords(s: Vec<&str>, p: &str) -> u32 {
    s.iter().filter(|w| w.starts_with(p)).collect::<Vec<_>>().len() as u32
}
