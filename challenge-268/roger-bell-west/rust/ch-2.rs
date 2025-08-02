#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(numbergame(vec![2, 5, 3, 4]), vec![3, 2, 5, 4]);
}

#[test]
fn test_ex2() {
    assert_eq!(
        numbergame(vec![9, 4, 1, 3, 6, 4, 6, 1]),
        vec![1, 1, 4, 3, 6, 4, 9, 6]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(numbergame(vec![1, 2, 2, 3]), vec![2, 1, 3, 2]);
}

fn numbergame(a0: Vec<i32>) -> Vec<i32> {
    let mut out = Vec::new();
    let mut a = a0;
    a.sort();
    let mut ai = a.iter();
    while let Some(i) = ai.next() {
        out.push(*ai.next().unwrap());
        out.push(*i);
    }
    out
}
