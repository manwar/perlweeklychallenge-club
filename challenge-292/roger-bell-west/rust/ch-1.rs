#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(twicelargest(vec![2, 4, 1, 0]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(twicelargest(vec![1, 2, 3, 4]), -1);
}

fn twicelargest(a: Vec<usize>) -> isize {
    let mut p = a.clone();
    p.sort();
    p.reverse();
    if p[0] >= 2 * p[1] {
        for (i, c) in a.iter().enumerate() {
            if *c == p[0] {
                return i as isize;
            }
        }
    }
    -1
}
