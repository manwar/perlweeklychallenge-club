#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sumdifference(vec![1, 23, 4, 5]), 18);
}

#[test]
fn test_ex2() {
    assert_eq!(sumdifference(vec![1, 2, 3, 4, 5]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(sumdifference(vec![1, 2, 34]), 27);
}

fn sumdifference(a: Vec<u32>) -> u32 {
    let mut delta = 0;
    for x in a {
        if x >= 10 {
            let mut digitsum = 0;
            let mut xa = x;
            while xa > 0 {
                digitsum += xa % 10;
                xa /= 10;
            }
            delta += x - digitsum;
        }
    }
    delta
}
