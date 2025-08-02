#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sumofvalues(vec![2, 5, 9, 11, 3], 1), 17);
}

#[test]
fn test_ex2() {
    assert_eq!(sumofvalues(vec![2, 5, 9, 11, 3], 2), 11);
}

#[test]
fn test_ex3() {
    assert_eq!(sumofvalues(vec![2, 5, 9, 11, 3], 0), 2);
}

fn sumofvalues(a: Vec<u32>, k: u32) -> u32 {
    a.iter()
        .enumerate()
        .filter(|(i, _n)| i.count_ones() == k)
        .map(|(_i, n)| n)
        .sum()
}
