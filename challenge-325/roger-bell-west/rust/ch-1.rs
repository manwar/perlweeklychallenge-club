#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(consecutiveone(vec![0, 1, 1, 0, 1, 1, 1]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(consecutiveone(vec![0, 0, 0, 0]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(consecutiveone(vec![1, 0, 1, 0, 1, 1]), 2);
}

fn consecutiveone(a: Vec<u8>) -> usize {
    let mut h = HashMap::new();
    h.insert(0, 0);
    let mut latch = 0;
    let mut latched = false;
    for (i, n) in a.iter().enumerate() {
        if *n == 1 && !latched {
            latched = true;
            latch = i;
        }
        if *n == 0 && latched {
            latched = false;
            h.insert(latch, i - latch);
        }
    }
    if latched {
        h.insert(latch, a.len() - latch);
    }
    *h.values().max().unwrap()
}
