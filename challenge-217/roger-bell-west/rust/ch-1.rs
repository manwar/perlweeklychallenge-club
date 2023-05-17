#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        sortedmatrix(vec![vec![3, 1, 2], vec![5, 2, 4], vec![0, 1, 3]]),
        1
    );
}

#[test]
fn test_ex2() {
    assert_eq!(sortedmatrix(vec![vec![2, 1], vec![4, 5]]), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(
        sortedmatrix(vec![vec![1, 0, 3], vec![0, 0, 0], vec![1, 2, 1]]),
        0
    );
}

fn sortedmatrix(matrix: Vec<Vec<i32>>) -> i32 {
    let mut n = matrix.iter().flatten().collect::<Vec<&i32>>();
    n.sort();
    *n[2]
}
