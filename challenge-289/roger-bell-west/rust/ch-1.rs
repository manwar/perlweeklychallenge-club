#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(thirdmaximum(vec![5, 6, 4, 1]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(thirdmaximum(vec![4, 5]), 5);
}

#[test]
fn test_ex3() {
    assert_eq!(thirdmaximum(vec![1, 2, 2, 3]), 1);
}

fn thirdmaximum(a: Vec<u32>) -> u32 {
    let mut p = a.clone();
    p.sort();
    p.reverse();
    p.dedup();
    if p.len() > 2 {
        p[2]
    } else {
        p[0]
    }
}
