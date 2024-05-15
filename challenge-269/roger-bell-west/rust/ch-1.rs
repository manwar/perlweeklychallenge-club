#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(bitwiseor(vec![1, 2, 3, 4, 5]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(bitwiseor(vec![2, 3, 8, 16]), true);
}

#[test]
fn test_ex3() {
    assert_eq!(bitwiseor(vec![1, 2, 5, 7, 9]), false);
}

fn bitwiseor(a: Vec<u32>) -> bool {
    a.into_iter().filter(|n| n % 2 == 0).count() >= 2
}
