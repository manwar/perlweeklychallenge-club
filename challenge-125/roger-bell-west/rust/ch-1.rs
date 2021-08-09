#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(pt(5),vec![vec![3,4,5],vec![5,12,13]]);
}

#[test]
fn test_ex2() {
    assert_eq!(pt(13),vec![vec![5,12,13],vec![13,84,85]]);
}

#[test]
fn test_ex3() {
    assert_eq!(pt(1),Vec::<Vec<i64>>::new());
}

fn pt(n: i64) -> Vec<Vec<i64>> {
    let mut out=vec![];
    let mut tri: VecDeque<Vec<i64>>=VecDeque::new();
    tri.push_back(vec![3,4,5]);
    while tri.len()>0 {
        let t=tri.pop_front().unwrap();
        for i in 0..=2 {
            if n % t[i] == 0 {
                let k=n/t[i];
                out.push(t.iter().map(|j| j*k).collect());
            }
        }
        if t.iter().min().unwrap() <= &n {
            tri.push_back(vec![
                t[0]-2*t[1]+2*t[2],
                2*t[0]-1*t[1]+2*t[2],
                2*t[0]-2*t[1]+3*t[2],
            ]);
            tri.push_back(vec![
                t[0]+2*t[1]+2*t[2],
                2*t[0]+1*t[1]+2*t[2],
                2*t[0]+2*t[1]+3*t[2],
            ]);
            tri.push_back(vec![
                -t[0]+2*t[1]+2*t[2],
                -2*t[0]+1*t[1]+2*t[2],
                -2*t[0]+2*t[1]+3*t[2],
            ]);
        }
    }
    return out;
}
