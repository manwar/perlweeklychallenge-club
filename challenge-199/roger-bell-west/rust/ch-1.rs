#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(goodpairs(vec![1, 2, 3, 1, 1, 3]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(goodpairs(vec![1, 2, 3]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(goodpairs(vec![1, 1, 1, 1]), 6);
}

fn goodpairs(l: Vec<usize>) -> usize {
    let mut c = 0;
    let mut k: HashMap<usize, usize> = HashMap::new();
    for i in l {
        let en = k.entry(i).or_insert(0);
        *en += 1;
    }
    for v in k.values() {
        c += v * (v - 1);
    }
    c / 2
}
