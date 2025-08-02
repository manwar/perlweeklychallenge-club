#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maximumones(vec![vec![0, 1], vec![1, 0]]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(maximumones(vec![vec![0, 0, 0], vec![1, 0, 1]]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(maximumones(vec![vec![0, 0], vec![1, 1], vec![0, 0]]), 2);
}

fn maximumones(a: Vec<Vec<u8>>) -> usize {
    let ax = a.into_iter().map(|r| r.into_iter().sum()).collect::<Vec<u8>>();
    let am = ax.clone().into_iter().max().unwrap();
    ax.into_iter()
        .enumerate()
        .filter(|(_i, n)| *n == am)
        .map(|(i, _n)| i)
        .nth(0)
        .unwrap()
        + 1
}
