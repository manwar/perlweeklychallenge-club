#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::cmp::min;

#[test]
fn test_ex1() {
    assert_eq!(ed("kitten","sitting"),3);
}

#[test]
fn test_ex2() {
    assert_eq!(ed("sunday","monday"),2);
}

#[test]
fn test_ex3() {
    assert_eq!(ed("branscombe","ranscombe"),1);
}

fn ed(s: &str, t: &str) -> usize {
    let mut ss: Vec<char>=vec!['0'];
    for c in s.chars() {
        ss.push(c);
    }
    let mut tt: Vec<char>=vec!['0'];
    for c in t.chars() {
        tt.push(c);
    }
    let mut d: Vec<Vec<usize>>=vec![vec![0; tt.len()]; ss.len()];
    for i in 1..ss.len() {
        d[i][0]=i;
    }
    for i in 1..tt.len() {
        d[0][i]=i;
    }
    for j in 1..tt.len() {
        for i in 1..ss.len() {
            let mut sc=0;
            if ss[i] != tt[j] {
                sc=1;
            }
            d[i][j]=min(
                d[i-1][j]+1,
                min(
                    d[i][j-1]+1,
                    d[i-1][j-1]+sc
                )
            );
        }
    }
    return d[ss.len()-1][tt.len()-1];
}
