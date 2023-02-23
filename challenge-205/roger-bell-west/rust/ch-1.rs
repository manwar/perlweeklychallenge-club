#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(thirdhighest(vec![5, 3, 4]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(thirdhighest(vec![5, 6]), 6);
}

#[test]
fn test_ex3() {
    assert_eq!(thirdhighest(vec![5, 4, 4, 3]), 3);
}

fn thirdhighest(l: Vec<i32>) -> i32 {
    let mut v = l.clone();
    v.sort();
    v.dedup();
    v.reverse();
    match v.len() {
        0 => 0,
        1..=2 => v[0],
        _ => v[2],
    }
}
