#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(oddsum(vec![2, 5, 3, 6, 4]), 77);
}

#[test]
fn test_ex2() {
    assert_eq!(oddsum(vec![1, 3]), 4);
}

fn oddsum(a: Vec<u32>) -> u32 {
    let mut out: u32 = a.iter().sum();
    let mut l = 3;
    while l <= a.len() {
        for s in a.windows(l) {
            out += s.into_iter().sum::<u32>();
        }
        l += 2;
    }
    out
}

