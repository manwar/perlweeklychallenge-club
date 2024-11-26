#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(semiorderedpermutation(vec![2, 1, 4, 3]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(semiorderedpermutation(vec![2, 4, 1, 3]), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(semiorderedpermutation(vec![1, 3, 2, 4, 5]), 0);
}

fn semiorderedpermutation(a: Vec<usize>) -> usize {
    let en = a.len();
    let mut s = 1;
    let mut e = en - 1;
    for (i, n) in a.iter().enumerate() {
        if *n == 1 {
            s = i;
        }
        if *n == en {
            e = i;
        }
    }
    let mut r = s + (en - 1 - e);
    if s > e {
        r -= 1;
    }
    r
}
