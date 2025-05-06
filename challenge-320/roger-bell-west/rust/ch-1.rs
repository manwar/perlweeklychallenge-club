#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maximumcount(vec![-3, -2, -1, 1, 2, 3]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(maximumcount(vec![-2, -1, 0, 0, 1]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(maximumcount(vec![1, 2, 3, 4]), 4);
}

fn maximumcount(a: Vec<i32>) -> usize {
    let mut pos = 0;
    let mut neg = 0;
    for n in a {
        if n > 0 {
            pos += 1;
        } else if n < 0 {
            neg += 1;
        }
    }
    std::cmp::max(pos, neg)
}
