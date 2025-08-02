#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(countevendigitsnumber(vec![10, 1, 111, 24, 1000]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(countevendigitsnumber(vec![111, 1, 11111]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(countevendigitsnumber(vec![2, 8, 1024, 256]), 1);
}

fn countevendigitsnumber(a: Vec<u32>) -> u32 {
    let mut t = 0;
    for p in a {
        let mut even = false;
        let mut pt = p;
        while pt >= 10 {
            pt /= 10;
            even = !even;
        }
        if even {
            t += 1;
        }
    }
    t
}
