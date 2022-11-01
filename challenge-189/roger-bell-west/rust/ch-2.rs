#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(arraydegree(vec![1, 3, 3, 2]), vec![3, 3]);
}

#[test]
fn test_ex2() {
    assert_eq!(arraydegree(vec![1, 2, 1, 3]), vec![1, 2, 1]);
}

#[test]
fn test_ex3() {
    assert_eq!(arraydegree(vec![1, 3, 2, 1, 2]), vec![2, 1, 2]);
}

#[test]
fn test_ex4() {
    assert_eq!(arraydegree(vec![1, 1, 2, 3, 2]), vec![1, 1]);
}

#[test]
fn test_ex5() {
    assert_eq!(arraydegree(vec![2, 1, 2, 1, 1]), vec![1, 2, 1, 1]);
}

fn arraydegree(a: Vec<usize>) -> Vec<usize> {
    let mut f = HashMap::new();
    for x in a.clone() {
        let en = f.entry(x).or_insert(0);
        *en += 1;
    }
    let degree = f.values().max().unwrap();
    let mut inverse = HashMap::new();
    let aa = a.clone();
    for (i, x) in aa.iter().enumerate() {
        let en = inverse.entry(x).or_insert(Vec::new());
        en.push(i);
    }
    let mut minlen = 1 + a.len();
    let mut se = vec![0, 1];
    for n in f.keys().filter(|x| f.get(&x).unwrap() == degree) {
        let ll = 1 + inverse.get(&n).unwrap().last().unwrap()
            - inverse.get(&n).unwrap()[0];
        if ll < minlen {
            minlen = ll;
            se = vec![
                inverse.get(&n).unwrap()[0],
                *inverse.get(&n).unwrap().last().unwrap(),
            ];
        }
    }
    return a[se[0]..=se[1]].to_vec();
}
