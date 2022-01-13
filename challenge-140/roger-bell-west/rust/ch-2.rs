#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(mtable(2,3,4),3);
}

#[test]
fn test_ex2() {
    assert_eq!(mtable(3,3,6),4);
}

fn mtable(i: u32,j: u32,k: usize) -> u32 {
    let mut l=vec![];
    for ix in 1..=i {
        for jx in 1..=j {
            l.push(ix*jx);
        }
    }
    l.sort();
    return l[k-1];
}
