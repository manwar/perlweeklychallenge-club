#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(specialintegers(15), 14);
}

#[test]
fn test_ex2() {
    assert_eq!(specialintegers(35), 32);
}

fn specialintegers(n: usize) -> usize {
    let mut o = 0;
    for i in 1..=n {
        let mut s = true;
        let mut f: HashSet<char> = HashSet::new();
        for c in i.to_string().chars() {
            if f.contains(&c) {
                s = false;
                break;
            } else {
                f.insert(c);
            }
        }
        if s {
            o += 1;
        }
    }
    o
}
