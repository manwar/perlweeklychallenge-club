#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(hammingdistance(vec![4, 14, 2]), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(hammingdistance(vec![4, 14, 4]), 4);
}

fn hammingdistance(a: Vec<u32>) -> u32 {
    let mut t = 0;
    for i in 0..a.len() - 1 {
        for j in i + 1..a.len() {
            t += (a[i] ^ a[j]).count_ones();
        }
    }
    t
}
