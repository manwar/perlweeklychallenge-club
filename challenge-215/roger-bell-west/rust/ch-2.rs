#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(numberplacement(vec![1, 0, 0, 0, 1], 1), true);
}

#[test]
fn test_ex2() {
    assert_eq!(numberplacement(vec![1, 0, 0, 0, 1], 2), false);
}

#[test]
fn test_ex3() {
    assert_eq!(numberplacement(vec![1, 0, 0, 0, 0, 0, 0, 0, 1], 3), true);
}

fn numberplacement(a0: Vec<u8>, ct: u32) -> bool {
    let mut a: Vec<u8> = vec![1; a0.len() + 2];
    a.splice( 1 ..= a0.len(), a0);
    let mut s = 0;
    let mut tt = 0;
    for i in 1 .. a.len() {
        match (a[i - 1], a[i]) {
            (1, 0) => { s = i; },
            (0, 1) => { tt += (i - s) / 2; },
            _ => (),
        }
    }
    ct <= tt as u32
}
