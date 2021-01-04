#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(ga(vec!["opt".to_string(),"bat".to_string(),"saw".to_string(),"tab".to_string(),"pot".to_string(),"top".to_string(),"was".to_string()]),vec![vec!["bat".to_string(),"tab".to_string()],vec!["opt".to_string(),"pot".to_string(),"top".to_string()],vec!["saw".to_string(),"was".to_string()]]);
}

#[test]
fn test_ex2() {
    assert_eq!(ga(vec!["x".to_string()]),vec![vec!["x".to_string()]]);
}

fn ga(l: Vec<String>) -> Vec<Vec<String>> {
    let mut g: HashMap<u128,Vec<String>>=HashMap::new();
    for word in l {
        let h=wh(&word);
        let mut e: Vec<String>=vec![];
        if g.contains_key(&h) {
            e=g.get(&h).unwrap().to_vec();
        }
        e.push(word);
        g.insert(h,e);
    }
    let mut r: Vec<Vec<String>>=vec![];
    for (_k,v) in g {
        let mut vv=v.clone();
        vv.sort();
        r.push(vv);
    }
    r.sort();
    return r;
}

fn wh (word: &String) -> u128 {
    let pr=vec![2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101];
    let mut n: u128 = 1;
    for i in word.chars() {
        n*=pr[(i.to_digit(36).unwrap()-10) as usize];
    }
    return n;
}
