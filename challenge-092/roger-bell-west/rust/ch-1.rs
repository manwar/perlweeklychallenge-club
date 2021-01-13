#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(isos("abc".to_string(),"xyz".to_string()),1);
}

#[test]
fn test_ex2() {
    assert_eq!(isos("abb".to_string(),"xyy".to_string()),1);
}

#[test]
fn test_ex3() {
    assert_eq!(isos("sum".to_string(),"add".to_string()),0);
}

fn isos(a: String,b: String) -> i64 {
    if &a.len() != &b.len() {
        return 0;
    }
    let s: Vec<Vec<char>>=vec![a.chars().collect(),b.chars().collect()];
    let mut lt: std::vec::Vec<std::collections::HashMap<char, i64>> = vec![HashMap::new(),HashMap::new()];
    let mut n=vec![0,0];
    for ci in 0..s[0].len() {
        let mut r: std::vec::Vec<i64>=vec![];
        for si in 0 as usize..=1 {
            if lt[si].contains_key(&s[si][ci]) {
                r.push(*lt[si].get(&s[si][ci]).unwrap());
            } else {
                lt[si].insert(s[si][ci],n[si]);
                r.push(n[si]);
                n[si]+=1;
            }
        }
        if r[0] != r[1] {
            return 0;
        }
    }
    return 1;
}
