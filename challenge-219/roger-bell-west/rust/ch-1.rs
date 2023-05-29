#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sortedsquares(vec![-2, -1, 0, 3, 4]), vec![0, 1, 4, 9, 16]);
}

#[test]
fn test_ex2() {
    assert_eq!(sortedsquares(vec![5, -4, -1, 3, 6]), vec![1, 9, 16, 25, 36]);
}

fn sortedsquares(lst: Vec<i32>) -> Vec<i32> {
    let mut q = lst.iter().map(|i| i * i).collect::<Vec<i32>>();
    q.sort();
    q
}
