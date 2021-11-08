#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(un(7),8);
}

#[test]
fn test_ex2() {
    assert_eq!(un(10),12);
}

#[test]
fn test_ex3() {
    assert_eq!(un(200),16200);
}

fn un(m: u64) -> u64 {
    let mut n=0;
    let mut s: Vec<VecDeque<u64>>=vec![];
    for _j in 0..=2 {
        let mut p: VecDeque<u64>=VecDeque::new();
        p.push_back(1);
        s.push(p);
    }
    let c=vec![2,3,5];
    for _j in 1..=m {
        n=*[s[0][0],s[1][0],s[2][0]].iter().min().unwrap();
        for i in 0..=2 {
            if s[i][0]==n {
                s[i].pop_front();
            }
            s[i].push_back(n*c[i]);
        }
    }
    return n;
}
