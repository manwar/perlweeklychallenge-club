#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(peakpositions(vec![1, 3, 2]), vec![1]);
}

#[test]
fn test_ex2() {
    assert_eq!(peakpositions(vec![2, 4, 6, 5, 3]), vec![2]);
}

#[test]
fn test_ex3() {
    assert_eq!(peakpositions(vec![1, 2, 3, 2, 4, 1]), vec![2, 4]);
}

#[test]
fn test_ex4() {
    assert_eq!(peakpositions(vec![5, 3, 1]), vec![0]);
}

#[test]
fn test_ex5() {
    assert_eq!(peakpositions(vec![1, 5, 1, 5, 1, 5, 1]), vec![1, 3, 5]);
}

fn peakpositions(a: Vec<i32>) -> Vec<usize> {
    let mut out = Vec::new();
    for (i, x) in a.iter().enumerate() {
        if (i == 0 || *x > a[i - 1]) && (i == a.len() - 1 || *x > a[i + 1]) {
            out.push(i);
        }
    }
    out
}
