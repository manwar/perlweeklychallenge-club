#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        finishingorder(vec![3, 1, 4, 2, 5], vec![1, 4, 2]),
        vec![1, 4, 2]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        finishingorder(vec![5, 4, 3, 2, 1], vec![1, 3, 5]),
        vec![5, 3, 1]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        finishingorder(vec![2, 4, 1, 3], vec![1, 2, 3, 4]),
        vec![2, 4, 1, 3]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(finishingorder(vec![4, 1, 3, 2], vec![3]), vec![3]);
}

#[test]
fn test_ex5() {
    assert_eq!(
        finishingorder(vec![1, 3, 2, 6, 5, 4], vec![1, 2, 3]),
        vec![1, 3, 2]
    );
}

use std::collections::HashSet;

fn finishingorder(order: Vec<u32>, friends: Vec<u32>) -> Vec<u32> {
    let wanted = friends.into_iter().collect::<HashSet<u32>>();
    order.into_iter().filter(|x| wanted.contains(&x)).collect::<Vec<u32>>()
}
