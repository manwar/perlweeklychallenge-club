#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, HashSet};

#[test]
fn test_ex1() {
    assert_eq!(
        arrayloops(vec![
            4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9,
            10
        ]),
        3
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        arrayloops(vec![
            0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15,
            19
        ]),
        6
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        arrayloops(vec![
            9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6,
            17
        ]),
        1
    );
}

fn arrayloops(a: Vec<usize>) -> usize {
    let mut loop_id = 0;
    let mut loops: HashMap<usize, usize> = HashMap::new();
    for origin in 0..a.len() {
        if !loops.contains_key(&origin) {
            let mut li = 0;
            let mut thisloop: HashSet<usize> = HashSet::new();
            let mut x = origin;
            loop {
                if x >= a.len() {
                    break;
                }
                thisloop.insert(x);
                x = a[x];
                if loops.contains_key(&x) {
                    li = *loops.get(&x).unwrap();
                    break;
                }
                if thisloop.contains(&x) {
                    loop_id += 1;
                    li = loop_id;
                    break;
                }
            }
            for i in thisloop {
                loops.insert(i, li);
            }
        }
    }
    loop_id
}
