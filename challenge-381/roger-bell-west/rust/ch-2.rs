#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(smallergreaterelement(vec![2, 4]), 0);
}

#[test]
fn test_ex2() {
    assert_eq!(smallergreaterelement(vec![1, 1, 1, 1]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(smallergreaterelement(vec![1, 1, 4, 8, 12, 12]), 2);
}

#[test]
fn test_ex4() {
    assert_eq!(smallergreaterelement(vec![3, 6, 6, 9]), 2);
}

#[test]
fn test_ex5() {
    assert_eq!(smallergreaterelement(vec![0, -5, 10, -2, 4]), 3);
}

fn smallergreaterelement(a: Vec<i32>) -> usize {
    let mn = a.iter().min().unwrap();
    let mx = a.iter().max().unwrap();
    a.iter().filter(|x| *x > mn && *x < mx).count()
}
