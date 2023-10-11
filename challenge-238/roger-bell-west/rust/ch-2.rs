#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(persistencearray(vec![15, 99, 1, 34]), vec![1, 15, 34, 99]);
}

#[test]
fn test_ex2() {
    assert_eq!(persistencearray(vec![50, 25, 33, 22]), vec![22, 33, 50, 25]);
}

fn persistence(a: u32) -> u32 {
    let mut steps = 0;
    let mut b = a;
    while b > 9 {
        steps += 1;
        let mut p = 1;
        while b > 0 {
            p *= b % 10;
            b /= 10;
        }
        b = p;
    }
    steps
}

fn persistencearray(a: Vec<u32>) -> Vec<u32> {
    let mut b = a;
    b.sort();
    b.sort_by_cached_key(|i| persistence(*i));
    b
}
