#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(funsort(vec![1, 2, 3, 4, 5, 6]), vec![2, 4, 6, 1, 3, 5]);
}

#[test]
fn test_ex2() {
    assert_eq!(funsort(vec![1, 2]), vec![2, 1]);
}

#[test]
fn test_ex3() {
    assert_eq!(funsort(vec![1]), vec![1]);
}

fn funsort(l0: Vec<u32>) -> Vec<u32> {
    let mut l = l0.clone();
    l.sort();
    let mut a = Vec::new();
    let mut b = Vec::new();
    for k in l {
        if k % 2 == 0 {
            a.push(k);
        } else {
            b.push(k);
        }
    }
    a.append(&mut b);
    a
}
