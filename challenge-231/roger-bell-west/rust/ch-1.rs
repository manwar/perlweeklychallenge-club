#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(notminmax(vec![3, 2, 1, 4]), vec![3, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(notminmax(vec![3, 1]), Vec::<u32>::new());
}

#[test]
fn test_ex3() {
    assert_eq!(notminmax(vec![2, 1, 3]), vec![2]);
}

fn notminmax(a: Vec<u32>) -> Vec<u32> {
    let mn = a.iter().min().unwrap();
    let mx = a.iter().max().unwrap();
    a.iter().filter(|x| *x > mn && *x < mx).map(|x| *x).collect::<Vec<_>>()
}
