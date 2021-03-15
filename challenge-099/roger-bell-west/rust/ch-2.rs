#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(us("littleit","lit"),5);
}

#[test]
fn test_ex2() {
    assert_eq!(us("london","lon"),3);
}

fn us(text: &str,mat: &str) -> usize {
    let mut s: HashMap<char,Vec<usize>>=HashMap::new();
    for (i,c) in text.chars().enumerate() {
        let mut sc: Vec<usize>=vec![];
        if s.contains_key(&c) {
            sc=s.get(&c).unwrap().to_vec();
        }
        sc.push(i);
        s.insert(c,sc);
    }
    let mut j: Vec<Vec<usize>>=vec![];
    for c in mat.chars() {
        if s.contains_key(&c) {
            j.push(s.get(&c).unwrap().to_vec());
        } else {
            return 0;
        }
    }
    let mut o: Vec<usize>=vec![1; j[0].len()];
    for m in 1..j.len() {
        let mut n: Vec<usize>=vec![];
        for bi in 0..j[m].len() {
            let mut t: usize=0;
            for ai in 0..j[m-1].len() {
                if j[m-1][ai] < j[m][bi] {
                    t += o[ai];
                }
            }
            n.push(t);
        }
        o=n;
    }
    return o.iter().sum();
}
