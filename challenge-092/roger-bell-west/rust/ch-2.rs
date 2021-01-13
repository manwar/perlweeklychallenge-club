#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::cmp;

#[test]
fn test_ex1() {
    assert_eq!(ii(vec![vec![1,4],vec![8,10]],vec![2,6]),vec![vec![1,6],vec![8,10]]);
}

#[test]
fn test_ex2() {
    assert_eq!(ii(vec![vec![1,2],vec![3,7],vec![8,10]],vec![5,8]),vec![vec![1,2],vec![3,10]]);
}

#[test]
fn test_ex3() {
    assert_eq!(ii(vec![vec![1,5],vec![7,9]],vec![10,11]),vec![vec![1,5],vec![7,9],vec![10,11]]);
}

#[test]
fn test_ex4() {
    assert_eq!(ii(vec![vec![7,9],vec![10,11]],vec![1,5]),vec![vec![1,5],vec![7,9],vec![10,11]]);
}

#[test]
fn test_ex5() {
    assert_eq!(ii(vec![vec![1,5],vec![10,11]],vec![7,9]),vec![vec![1,5],vec![7,9],vec![10,11]]);
}

fn ii(iv: Vec<Vec<i64>>,nv: Vec<i64>) -> Vec<Vec<i64>> {
    let mut q=iv;
    q.push(nv);
    q.sort_by(|a,b| a[0].cmp(&b[0]));
    let mut out: Vec<Vec<i64>>=vec![];
    for il in q {
        let oi=out.len();
        if oi == 0 ||
            out[oi-1][1] < il[0] {
                out.push(il);
            } else {
                out[oi-1][1]=cmp::max(out[oi-1][1],il[1]);
            }
    }
    return out;
}
