#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(brokenkeyboard("Hello World", vec!["d"]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(brokenkeyboard("apple banana cherry", vec!["a", "e"]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(brokenkeyboard("Coding is fun", Vec::<&str>::new()), 3);
}

#[test]
fn test_ex4() {
    assert_eq!(brokenkeyboard("The Weekly Challenge", vec!["a", "b"]), 2);
}

#[test]
fn test_ex5() {
    assert_eq!(brokenkeyboard("Perl and Python", vec!["p"]), 1);
}

fn brokenkeyboard(a: &str, b: Vec<&str>) -> usize {
    let bk = b
        .into_iter()
        .map(|x| x.to_ascii_lowercase().chars().nth(0).unwrap())
        .collect::<HashSet<_>>();
    let mut ct = 0;
    for w in a.split(" ") {
        let nk = w.to_ascii_lowercase().chars().collect::<HashSet<_>>();
        let inter = nk.intersection(&bk);
        if inter.count() == 0 {
            ct += 1;
        }
    }
    ct
}
