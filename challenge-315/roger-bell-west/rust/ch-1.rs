#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        findwords(vec!["the", "weekly", "challenge"], "e"),
        vec![0, 1, 2]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(findwords(vec!["perl", "raku", "python"], "p"), vec![0, 2]);
}

#[test]
fn test_ex3() {
    assert_eq!(findwords(vec!["abc", "def", "bbb", "bcd"], "b"), vec![0, 2, 3]);
}

fn findwords(a: Vec<&str>, b: &str) -> Vec<usize> {
    a.into_iter()
        .enumerate()
        .filter(|(_i, x)| x.contains(b))
        .map(|(i, _x)| i)
        .collect::<Vec<usize>>()
}
