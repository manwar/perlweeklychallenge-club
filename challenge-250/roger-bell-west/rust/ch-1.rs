#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(smallestindex(vec![0, 1, 2]), 0);
}

#[test]
fn test_ex2() {
    assert_eq!(smallestindex(vec![4, 3, 2, 1]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(smallestindex(vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 0]), -1);
}

fn smallestindex(a: Vec<i32>) -> i32 {
    for (ii, n) in a.iter().enumerate() {
        let i = ii as i32;
        if n % 10 == i {
            return i;
        }
    }
    -1
}
