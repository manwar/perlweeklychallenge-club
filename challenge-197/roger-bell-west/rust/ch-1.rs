#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(movezero(vec![1, 0, 3, 0, 0, 5]), vec![1, 3, 5, 0, 0, 0]);
}

#[test]
fn test_ex2() {
    assert_eq!(movezero(vec![1, 6, 4]), vec![1, 6, 4]);
}

#[test]
fn test_ex3() {
    assert_eq!(movezero(vec![0, 1, 0, 2, 0]), vec![1, 2, 0, 0, 0]);
}

fn movezero(l: Vec<isize>) -> Vec<isize> {
    let t = l.len();
    let mut o: Vec<isize> = l.into_iter().filter(|i| *i != 0).collect();
    o.append(&mut vec![0; t-o.len()]);
    o
}
