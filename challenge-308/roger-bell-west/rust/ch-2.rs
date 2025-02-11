#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(decodexor(vec![1, 2, 3], 1), vec![1, 0, 2, 1]);
}

#[test]
fn test_ex2() {
    assert_eq!(decodexor(vec![6, 2, 7, 3], 4), vec![4, 2, 0, 7, 4]);
}

fn decodexor(a: Vec<u32>, init: u32) -> Vec<u32> {
    let mut out = vec![init];
    for v in a {
        out.push(out[out.len() - 1] ^ v);
    }
    out
}
