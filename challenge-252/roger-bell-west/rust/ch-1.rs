#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(specialnumbers(vec![1, 2, 3, 4]), 21);
}

#[test]
fn test_ex2() {
    assert_eq!(specialnumbers(vec![2, 7, 1, 19, 18, 3]), 63);
}

fn specialnumbers(a: Vec<u32>) -> u32 {
    a.iter()
        .enumerate()
        .filter(|(i, _n)| a.len() % (i + 1) == 0)
        .map(|(_i, n)| n * n)
        .sum()
}
