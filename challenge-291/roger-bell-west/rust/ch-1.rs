#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(middleindex(vec![2, 3, -1, 8, 4]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(middleindex(vec![1, -1, 4]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(middleindex(vec![2, 5]), -1);
}

fn middleindex(a: Vec<i32>) -> i32 {
    let mut r: i32 = a.iter().sum();
    let mut l = 0;
    for (i, c) in a.iter().enumerate() {
        r -= c;
        if r == l {
            return i as i32;
        }
        l += c;
    }
    -1
}
