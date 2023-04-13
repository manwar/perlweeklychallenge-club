#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(
        rearrangegroups(vec![1, 2, 3, 5, 1, 2, 7, 6, 3], 3),
        vec![vec![1, 2, 3], vec![1, 2, 3], vec![5, 6, 7]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(rearrangegroups(vec![1, 2, 3], 2), Vec::<Vec<i32>>::new());
}

#[test]
fn test_ex3() {
    assert_eq!(rearrangegroups(vec![1, 2, 4, 3, 5, 3], 3), vec![vec![1, 2, 3], vec![3, 4, 5]]);
}

#[test]
fn test_ex4() {
    assert_eq!(rearrangegroups(vec![1, 5, 2, 6, 4, 7], 3), Vec::<Vec<i32>>::new());
}

fn rearrangegroups(list: Vec<i32>, size: i32) -> Vec<Vec<i32>> {
    let mut h: HashMap<i32, usize> = HashMap::new();
    for k in list {
        let en = h.entry(k).or_insert(0);
        *en += 1;
    }
    let mut out = Vec::new();
    loop {
        let m = h.keys().min().unwrap();
        let res = (*m..m + size).collect::<Vec<i32>>();
        for n in &res {
            if h.contains_key(n) {
                let p = h.get(n).unwrap() - 1;
                if p == 0 {
                    h.remove(n);
                } else {
                    h.insert(*n, p);
                }
            } else {
                return Vec::new();
            }
        }
        out.push(res);
        if h.len() == 0 {
            break;
        }
    }
    out
}
