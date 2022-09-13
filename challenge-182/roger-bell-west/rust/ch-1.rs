#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maxindex(vec![5, 2, 9, 1, 7, 6]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(maxindex(vec![4, 2, 3, 1, 5, 0]), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(maxindex(vec![4, 2, 3, 1, 4, 0]), 0);
}

fn maxindex(n: Vec<isize>) -> usize {
    let mut mxv = 0;
    let mut mxi = 0;
    for (i, v) in n.iter().enumerate() {
        if i == 0 || *v > mxv {
            mxv = *v;
            mxi = i;
        }
    }
    mxi
}
