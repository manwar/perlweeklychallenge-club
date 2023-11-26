#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maximisegreatness(vec![1, 3, 5, 2, 1, 3, 1]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(maximisegreatness(vec![1, 2, 3, 4]), 3);
}

fn maximisegreatness(a: Vec<u32>) -> u32 {
    let mut b = a;
    b.sort();
    let mut g = 0;
    for c in &b {
        if c > &b[g] {
            g += 1;
        }
    }
    g as u32
}
