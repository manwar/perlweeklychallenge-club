#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(strongpassword("a"), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(strongpassword("aB2"), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(strongpassword("PaaSW0rd"), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(strongpassword("Paaasw0rd"), 1);
}

#[test]
fn test_ex5() {
    assert_eq!(strongpassword("aaaaa"), 3);
}

fn strongpassword(a: &str) -> u32 {
    let mut ctypes = HashMap::new();
    let mut reps = 0;
    let mut rep = 0;
    let mut old = '@';
    let mut changes: Vec<u32> = Vec::new();
    for (i, c) in a.chars().enumerate() {
        if i > 0 && c == old {
            rep += 1;
            if rep >= 2 {
                reps += 1;
            }
        } else {
            rep = 0;
            old = c;
        }
        let mut t = 'n';
        if c.is_ascii_uppercase() {
            t = 'u';
        } else if c.is_ascii_lowercase() {
            t = 'l';
        } else if c.is_digit(10) {
            t = 'd';
        }
        let en = ctypes.entry(t).or_insert(0);
        *en += 1;
    }
    changes.push(reps);
    ctypes.remove(&'n');
    let k = ctypes.keys().count();
    if k < 3 {
        let spare = (ctypes.values().sum::<usize>() as i32) - (k as i32);
        if spare < 0 {
            changes.push(-spare as u32);
        }
    }
    if a.len() < 6 {
        changes.push((6 - a.len()) as u32);
    }
    *changes.iter().max().unwrap()
}
