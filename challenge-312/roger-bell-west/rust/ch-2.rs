#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, HashSet};

#[test]
fn test_ex1() {
    assert_eq!(ballsandboxes("G0B1R2R0B0"), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(ballsandboxes("G1R3R6B3G6B1B6R1G3"), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(ballsandboxes("B3B2G1B3"), 0);
}

fn ballsandboxes(a: &str) -> usize {
    let mut boxes: HashMap<usize, HashSet<char>> = HashMap::new();
    let mut colour = '@';
    for (i, c) in a.chars().enumerate() {
        if i % 2 == 0 {
            colour = c;
        } else {
            let boxid = c.to_digit(10).unwrap() as usize;
            let en = boxes.entry(boxid).or_insert(HashSet::new());
            (*en).insert(colour);
        }
    }
    boxes.values().filter(|x| x.len() >= 3).count()
}
