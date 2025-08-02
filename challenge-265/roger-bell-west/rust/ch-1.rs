#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(
        thirtythreepercentappearance(vec![1, 2, 3, 3, 3, 4, 2]),
        Some(3)
    );
}

#[test]
fn test_ex2() {
    assert_eq!(thirtythreepercentappearance(vec![1, 1]), Some(1));
}

#[test]
fn test_ex3() {
    assert_eq!(thirtythreepercentappearance(vec![1, 2, 3]), Some(1));
}

fn thirtythreepercentappearance(a: Vec<i32>) -> Option<i32> {
    let mut c: HashMap<i32, usize> = HashMap::new();
    for n in &a {
        let e = c.entry(*n).or_insert(0);
        *e += 1;
    }
    let mut threshold = a.len() * 33 / 100;
    if threshold * 100 / 33 != a.len() {
        threshold += 1;
    }
    c.retain(|_, v| *v >= threshold);
    c.keys().copied().min()
}
