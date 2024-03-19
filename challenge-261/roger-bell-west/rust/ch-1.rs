#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(elementdigitsum(vec![1, 2, 3, 45]), 36);
}

#[test]
fn test_ex2() {
    assert_eq!(elementdigitsum(vec![1, 12, 3]), 9);
}

#[test]
fn test_ex3() {
    assert_eq!(elementdigitsum(vec![1, 2, 3, 4]), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(elementdigitsum(vec![236, 416, 336, 350]), 1296);
}

fn elementdigitsum(a: Vec<u32>) -> u32 {
    let mut delta = 0;
    for n0 in a {
        let mut n = n0 / 10;
        let mut m = 10;
        while n > 0 {
            delta += (n % 10) * (m - 1);
            n /= 10;
            m *= 10;
        }
    }
    delta
}
