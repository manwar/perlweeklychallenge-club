#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sortoddeven(vec![4, 1, 2, 3]), vec![2, 3, 4, 1]);
}

#[test]
fn test_ex2() {
    assert_eq!(sortoddeven(vec![3, 1]), vec![3, 1]);
}

#[test]
fn test_ex3() {
    assert_eq!(sortoddeven(vec![5, 3, 2, 1, 4]), vec![2, 3, 4, 1, 5]);
}

fn sortoddeven(a: Vec<u32>) -> Vec<u32> {
    let mut odds = Vec::new();
    let mut evens = Vec::new();
    for (i, x) in a.into_iter().enumerate() {
        if i % 2 == 0 {
            evens.push(x);
        } else {
            odds.push(x);
        }
    }
    evens.sort();
    odds.sort();
    odds.reverse();
    let mut out = Vec::new();
    for i in 0 .. std::cmp::max(evens.len(), odds.len()) {
        if i < evens.len() {
            out.push(evens[i]);
        }
        if i < odds.len() {
            out.push(odds[i]);
        }
    }
    out
}
