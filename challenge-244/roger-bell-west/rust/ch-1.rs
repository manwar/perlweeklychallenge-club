#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(countsmaller(vec![8, 1, 2, 2, 3]), vec![4, 0, 1, 1, 3]);
}

#[test]
fn test_ex2() {
    assert_eq!(countsmaller(vec![6, 5, 4, 8]), vec![2, 1, 0, 3]);
}

#[test]
fn test_ex3() {
    assert_eq!(countsmaller(vec![2, 2, 2]), vec![0, 0, 0]);
}

fn countsmaller(nums: Vec<u32>) -> Vec<u32> {
    let mut b = nums.clone();
    b.sort();
    let mut sm: HashMap<u32, u32> = HashMap::new();
    let mut l = 0;
    for (i, e) in b.iter().enumerate() {
        if i == 0 || *e != l {
            sm.insert(*e, i as u32);
            l = *e;
        }
    }
    nums.into_iter().map(|n| *sm.get(&n).unwrap()).collect::<Vec<u32>>()
}
