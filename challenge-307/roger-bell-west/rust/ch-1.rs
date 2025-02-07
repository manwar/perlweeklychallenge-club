#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(checkorder(vec![5, 2, 4, 3, 1]), vec![0, 2, 3, 4]);
}

#[test]
fn test_ex2() {
    assert_eq!(checkorder(vec![1, 2, 1, 1, 3]), vec![1, 3]);
}

#[test]
fn test_ex3() {
    assert_eq!(checkorder(vec![3, 1, 3, 2, 3]), vec![0, 1, 3]);
}

fn checkorder(a: Vec<u32>) -> Vec<usize> {
    let mut b = a.clone();
    b.sort();
    a.into_iter()
        .enumerate()
        .filter(|(i, c)| b[*i] != *c)
        .map(|(i, _c)| i)
        .collect::<Vec<usize>>()
}
