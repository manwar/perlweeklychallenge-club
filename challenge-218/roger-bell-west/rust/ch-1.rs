#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maximumproduct(vec![3, 1, 2]), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(maximumproduct(vec![4, 1, 3, 2]), 24);
}

#[test]
fn test_ex3() {
    assert_eq!(maximumproduct(vec![-1, 0, 1, 3, 1]), 3);
}

#[test]
fn test_ex4() {
    assert_eq!(maximumproduct(vec![-8, 2, -9, 0, -4, 3]), 216);
}

fn maximumproduct(lst: Vec<i32>) -> i32 {
    let mut l = lst;
    l.sort();
    let b = l.len();
    let mut t: Vec<i32> = Vec::new();
    for i in 0..=3 {
        let mut p = 1;
        if i > 0 {
            for j in 0..i {
                p *= l[j];
            }
        }
        if i < 3 {
            for j in b - 3 + i..b {
                p *= l[j];
            }
        }
        t.push(p);
    }
    t.into_iter().max().unwrap()
}
