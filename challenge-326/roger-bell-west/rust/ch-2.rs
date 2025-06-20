#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(decompressedlist(vec![1, 3, 2, 4]), vec![3, 4, 4]);
}

#[test]
fn test_ex2() {
    assert_eq!(decompressedlist(vec![1, 1, 2, 2]), vec![1, 2, 2]);
}

#[test]
fn test_ex3() {
    assert_eq!(decompressedlist(vec![3, 1, 3, 2]), vec![1, 1, 1, 2, 2, 2]);
}

fn decompressedlist(a: Vec<usize>) -> Vec<usize> {
    let mut out = Vec::new();
    for p in a.chunks(2) {
        let mut px = vec![p[1]; p[0]];
        out.append(&mut px);
    }
    out
}
