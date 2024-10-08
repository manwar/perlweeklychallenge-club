#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(doubleexist(vec![6, 2, 3, 3]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(doubleexist(vec![3, 1, 4, 13]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(doubleexist(vec![2, 1, 4, 2]), true);
}

fn doubleexist(a: Vec<u32>) -> bool {
    for i in 0..a.len() - 1 {
        for j in i + 1..a.len() {
            if a[i] == 2 * a[j] || a[j] == 2 * a[i] {
                return true;
            }
        }
    }
    false
}
