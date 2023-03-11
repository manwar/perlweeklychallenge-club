#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(h_index(vec![10, 8, 5, 4, 3]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(h_index(vec![25, 8, 5, 3, 3]), 3);
}

fn h_index(c0: Vec<usize>) -> usize {
    let mut c = c0.clone();
    c.sort();
    c.reverse();
    let mut h = 0;
    for (i, x) in c.iter().enumerate() {
        if i + 1 <= *x {
            h = i + 1;
        } else {
            break;
        }
    }
    h
}
