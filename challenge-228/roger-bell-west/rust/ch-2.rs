#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(emptyarray(vec![3, 4, 2]), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(emptyarray(vec![1, 2, 3]), 3);
}

fn emptyarray(a0: Vec<u32>) -> u32 {
    let mut t = 0;
    let mut a = VecDeque::from(a0);
    while a.len() > 0 {
        let mn = a.iter().min().unwrap();
        let i = a
            .iter()
            .enumerate()
            .filter(|(_i, v)| *v == mn)
            .map(|(i, _v)| i)
            .collect::<Vec<_>>()[0];
        t += 1 + (i as u32);
        a.remove(i);
    }
    t
}
