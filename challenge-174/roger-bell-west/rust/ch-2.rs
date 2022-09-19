#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(permutation2rank(vec![1,0,2]),2);
}

#[test]
fn test_ex2() {
    assert_eq!(rank2permutation(vec![0,1,2],1),vec![0,2,1]);
}

#[test]
fn test_ex3() {
    assert_eq!(permutation2rank(vec![2,0,3,1]),13);
}

#[test]
fn test_ex4() {
    assert_eq!(rank2permutation(vec![1,3,2,0],7),vec![1,0,3,2]);
}

fn permutation2rank(perm: Vec<usize>) -> usize {
    let mut n: usize = 0;
    let mut pp = perm.clone();
    pp.sort();
    let mut oi: Vec<usize> = Vec::new();
    let mut l = 1;
    for index in 2..=perm.len() {
        oi.push(l);
        l *= index;
    }
    oi.reverse();
    for index in 0..perm.len()-1 {
        let mut base: HashMap<usize,usize> = HashMap::new();
        for (i,e) in pp.iter().enumerate() {
            base.insert(*e,i);
        }
        n += oi[index] * *base.get(&perm[index]).unwrap();
        base.remove(&perm[index]);
        pp = base.keys().map(|i| *i).collect::<Vec<usize>>();
        pp.sort();
    }
    n
}

fn rank2permutation(perm: Vec<usize>, rank0: usize) -> Vec<usize> {
    let mut rank = rank0;
    let mut pp = perm.clone();
    pp.sort();
    let mut o: Vec<usize> = Vec::new();
    let mut oi: Vec<usize> = Vec::new();
    let mut l = 1;
    for index in 2..=perm.len() {
        oi.push(l);
        l *= index;
    }
    oi.reverse();
    for index in 0..perm.len()-1 {
        let ix = rank / oi[index];
        o.push(pp[ix]);
        pp = pp.iter().filter(|&x| x != &pp[ix]).map(|x| *x).collect::<Vec<usize>>();
        rank = rank % oi[index];
    }
    o.push(pp[0]);
    o
}
