#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(floorsum(vec![2, 5, 9]), 10);
}

#[test]
fn test_ex2() {
    assert_eq!(floorsum(vec![7, 7, 7, 7, 7, 7, 7]), 49);
}

fn floorsum(a: Vec<u32>) -> u32 {
    let mut n = 0;
    for iv in &a {
        for jv in &a {
            n += iv / jv;
        }
    }
    return n;
}
