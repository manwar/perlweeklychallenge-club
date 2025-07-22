#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(lastword("The Weekly Challenge"), 9);
}

#[test]
fn test_ex2() {
    assert_eq!(lastword("   Hello   World    "), 5);
}

#[test]
fn test_ex3() {
    assert_eq!(lastword("Let's begin the fun"), 3);
}

fn lastword(a: &str) -> usize {
    let w = a.split(" ").filter(|x| x.len() > 0).collect::<Vec<_>>();
    w[w.len() - 1].len()
}
