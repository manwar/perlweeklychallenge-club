#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(twicelargest(vec![1, 2, 3, 4]), false);
}

#[test]
fn test_ex2() {
    assert_eq!(twicelargest(vec![1, 2, 0, 5]), true);
}

#[test]
fn test_ex3() {
    assert_eq!(twicelargest(vec![2, 6, 3, 1]), true);
}

#[test]
fn test_ex4() {
    assert_eq!(twicelargest(vec![4, 5, 2, 3]), false);
}

fn twicelargest(l0: Vec<u64>) -> bool {
    let mut l = l0.clone();
    l.sort();
    l.reverse();
    l[0] >= 2 * l[1]
}
