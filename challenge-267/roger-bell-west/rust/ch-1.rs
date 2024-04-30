#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(productsign(vec![-1, -2, -3, -4, 3, 2, 1]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(productsign(vec![1, 2, 0, -2, -1]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(productsign(vec![-1, -1, 1, -1, 2]), -1);
}

fn productsign(a: Vec<i32>) -> i8 {
    let mut out = 1;
    for t in a {
        if t < 0 {
            out = -out;
        } else if t == 0 {
            out = 0;
            break;
        }
    }
    out
}
