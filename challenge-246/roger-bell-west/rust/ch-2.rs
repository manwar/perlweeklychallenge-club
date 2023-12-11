#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(linearrecurrencesecondorder(vec![1, 1, 2, 3, 5]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(linearrecurrencesecondorder(vec![4, 2, 4, 5, 7]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(linearrecurrencesecondorder(vec![4, 1, 2, -3, 8]), true);
}

fn linearrecurrencesecondorder(seq: Vec<i32>) -> bool {
    let a = &seq[0..=2];
    let b = &seq[1..=3];
    let c = &seq[2..=4];
    let q = (b[2] * a[0] - b[0] * a[2]) / (b[1] * a[0] - b[0] * a[1]);
    let p = (a[2] - a[1] * q) / a[0];
    p * a[0] + q * a[1] == a[2]
        && p * b[0] + q * b[1] == b[2]
        && p * c[0] + q * c[1] == c[2]
}
