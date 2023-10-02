#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(leftrightsumdiff(vec![10, 4, 8, 3]), vec![15, 1, 11, 22]);
}

#[test]
fn test_ex2() {
    assert_eq!(leftrightsumdiff(vec![1]), vec![0]);
}

#[test]
fn test_ex3() {
    assert_eq!(leftrightsumdiff(vec![1, 2, 3, 4, 5]), vec![14, 11, 6, 1, 10]);
}

fn leftrightsumdiff(a: Vec<i32>) -> Vec<i32> {
    let al = a.len() - 1;
    let mut left: Vec<i32> = vec![0];
    let mut right: Vec<i32> = vec![0];
    for i in 0..al {
        left.push(left[i] + a[i]);
        right.push(right[i] + a[al - i]);
    }
    right.reverse();
    left.iter()
        .zip(right.iter())
        .map(|(l, r)| (l - r).abs())
        .collect::<Vec<i32>>()
}
