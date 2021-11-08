#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::{HashMap,HashSet};

#[test]
fn test_ex1() {
    assert_eq!(sc(vec!["abc","dea","cd"]),1);
}

#[test]
fn test_ex2() {
    assert_eq!(sc(vec!["ade","cbd","fgh"]),0);
}

#[test]
fn test_ex3() {
    assert_eq!(sc(vec!["abc","dea","fgh","hif"]),0);
}

#[test]
fn test_ex4() {
    assert_eq!(sc(vec!["abc","dec","cfa","cgd"]),1);
}

#[test]
fn test_ex5() {
    assert_eq!(sc(vec!["abc","def","cd"]),0);
}

fn sc (n: Vec<&str>) -> i8 {
    let mut m: Vec<String>=vec![];
    let mut i: HashMap<String,Vec<usize>>=HashMap::new();
    for t in &n {
        m.push(t[t.len()-1..].to_string());
        let ss=&t.chars().nth(0).unwrap().to_string();
        let mut vv: Vec<usize>=vec![];
        if i.contains_key(ss) {
            vv=i.get(ss).unwrap().to_vec();
        }
        vv.push(m.len()-1);
        i.insert(ss.to_string(),vv);
    }
    let mut chain: Vec<Vec<usize>>=vec![vec![0]];
    while chain.len()>0 {
        let stub=chain.pop().unwrap();
        let mut v: HashSet<usize>=HashSet::new();
        for y in 0..n.len() {
            v.insert(y);
        }
        for y in &stub {
            v.remove(&y);
        }
        if v.len()>0 {
            if i.contains_key(&m[stub[stub.len()-1]]) {
                let xx=i.get(&m[stub[stub.len()-1]]).unwrap();
                let xx=xx.iter().filter(|x| v.contains(&x));
                for x in xx {
                    let mut s=stub.clone();
                    s.push(*x);
                    chain.push(s);
                }
            }
        } else {
            if i.contains_key(&m[stub[stub.len()-1]]) {
                let xx=i.get(&m[stub[stub.len()-1]]).unwrap();
                if xx[0]==0 {
                    return 1;
                }
            }
        }
    }
    return 0;
}
