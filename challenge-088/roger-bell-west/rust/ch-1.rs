#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(aop(vec![5, 2, 1, 4, 3]),vec![24, 60, 120, 30, 40]);
}

#[test]
fn test_ex2() {
    assert_eq!(aop(vec![2, 1, 4, 3],),vec![12, 24, 6, 8]);
}

fn aop(ns: Vec<i32>) -> Vec<i32> {
    let p=ns.iter().fold(1,|sum, item| sum * item);
    return ns.iter().map(|i| p/i).collect()
}
