#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(mingap(vec![2, 8, 10, 11, 15]), 11);
}

#[test]
fn test_ex2() {
    assert_eq!(mingap(vec![1, 5, 6, 7, 14]), 6);
}

#[test]
fn test_ex3() {
    assert_eq!(mingap(vec![8, 20, 25, 28]), 28);
}

fn mingap(a: Vec<u32>) -> u32 {
    let mut mg = a[a.len() - 1] - a[0];
    let mut mv = 0;
    for p in a.windows(2) {
        let delta = p[1] - p[0];
        if delta < mg {
            mg = delta;
            mv = p[1];
        }
    }
    mv
}
