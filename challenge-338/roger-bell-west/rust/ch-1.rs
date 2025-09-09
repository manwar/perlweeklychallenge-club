#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        highestrow(vec![vec![4, 4, 4, 4], vec![10, 0, 0, 0], vec![2, 2, 2, 9]]),
        16
    );
}

#[test]
fn test_ex2() {
    assert_eq!(highestrow(vec![vec![1, 5], vec![7, 3], vec![3, 5]]), 10);
}

#[test]
fn test_ex3() {
    assert_eq!(highestrow(vec![vec![1, 2, 3], vec![3, 2, 1]]), 6);
}

#[test]
fn test_ex4() {
    assert_eq!(
        highestrow(vec![vec![2, 8, 7], vec![7, 1, 3], vec![1, 9, 5]]),
        17
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        highestrow(vec![
            vec![10, 20, 30],
            vec![5, 5, 5],
            vec![0, 100, 0],
            vec![25, 25, 25]
        ]),
        100
    );
}

fn highestrow(a: Vec<Vec<u32>>) -> u32 {
    a.iter().map(|x| x.into_iter().sum()).max().unwrap()
}
