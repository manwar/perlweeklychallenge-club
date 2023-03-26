#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(specialbitcharacters(vec![1, 0, 0]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(specialbitcharacters(vec![1, 1, 1, 0]), false);
}

fn specialbitcharacters(a: Vec<u8>) -> bool {
    let mut s: u8 = 0;
    for v in a {
        if s == 1 {
            s = 2;
        } else {
            s = v;
        }
    }
    s == 0
}
