#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(ds(vec![1,2,5,3,4],vec![4,6,7,8,9]),0);
}

#[test]
fn test_ex2() {
    assert_eq!(ds(vec![1,3,5,7,9],vec![0,2,4,6,8]),1);
}

fn ds(a: Vec<i64>,b: Vec<i64>) -> u8 {
    let sa: HashSet<i64>=a.into_iter().collect();
    let sb: HashSet<i64>=b.into_iter().collect();
    let inter=sa.intersection(&sb);
    if inter.collect::<Vec<&i64>>().len()==0 {
        return 1;
    } else {
        return 0;
    }
}
