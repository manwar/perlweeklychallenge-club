#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(targetindex(vec![1, 5, 3, 2, 4, 2], 2), vec![1, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(targetindex(vec![1, 2, 4, 3, 5], 6), Vec::<usize>::new());
}

#[test]
fn test_ex3() {
    assert_eq!(targetindex(vec![5, 3, 2, 4, 2, 1], 4), vec![4]);
}

fn targetindex(a0: Vec<u32>, k: u32) -> Vec<usize> {
    let mut a = a0;
    a.sort();
    a.iter()
        .enumerate()
        .filter(|(_i, v)| **v == k)
        .map(|(i, _v)| i)
        .collect::<Vec<_>>()
}
