#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maxdistance(vec![4, 5, 7], vec![9, 1, 3, 4]), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(maxdistance(vec![2, 3, 5, 4], vec![3, 2, 5, 5, 8, 7]), 6);
}

#[test]
fn test_ex3() {
    assert_eq!(maxdistance(vec![2, 1, 11, 3], vec![2, 5, 10, 2]), 9);
}

#[test]
fn test_ex4() {
    assert_eq!(maxdistance(vec![1, 2, 3], vec![3, 2, 1]), 2);
}

#[test]
fn test_ex5() {
    assert_eq!(maxdistance(vec![1, 0, 2, 3], vec![5, 0]), 5);
}

fn maxdistance(a: Vec<i32>, b: Vec<i32>) -> i32 {
    let l1 = a.iter().min().unwrap();
    let h1 = a.iter().max().unwrap();
    let l2 = b.iter().min().unwrap();
    let h2 = b.iter().max().unwrap();
    *[h1 - l2, h2 - l1].iter().max().unwrap()
}
