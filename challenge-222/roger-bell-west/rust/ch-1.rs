#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(matchingmembers(vec![1, 1, 4, 2, 1, 3]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(matchingmembers(vec![5, 1, 2, 3, 4]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(matchingmembers(vec![1, 2, 3, 4, 5]), 5);
}

fn matchingmembers(a: Vec<u32>) -> u32 {
    let mut b = a.clone();
    b.sort();
    let mut o = 0;
    for (ae, be) in a.iter().zip(b.iter()) {
        if ae == be {
            o += 1;
        }
    }
    o
}
