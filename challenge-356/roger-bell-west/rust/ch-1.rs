#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(magicalstring(4), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(magicalstring(5), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(magicalstring(6), 3);
}

#[test]
fn test_ex4() {
    assert_eq!(magicalstring(7), 4);
}

#[test]
fn test_ex5() {
    assert_eq!(magicalstring(8), 4);
}

fn magicalstring(a: usize) -> usize {
    let mut s = vec![0; a * 2];
    s[0] = 1;
    let mut l = 1;
    let mut n = 0;
    let mut ic = 0;
    while ic < a {
        if s[n] == 2 {
            s[ic + 1] = l;
            ic += 1;
        }
        l = 3 - l;
        ic += 1;
        s[ic] = l;
        n += 1;
    }
    s.truncate(a);
    s.iter().filter(|x| **x == 1).count()
}
