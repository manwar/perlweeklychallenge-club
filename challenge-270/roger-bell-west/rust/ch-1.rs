#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        specialpositions(vec![vec![1, 0, 0], vec![0, 0, 1], vec![1, 0, 0]]),
        1
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        specialpositions(vec![vec![1, 0, 0], vec![0, 1, 0], vec![0, 0, 1]]),
        3
    );
}

fn validator(a0: &Vec<u8>) -> Option<usize> {
    let mut a = a0.clone();
    a.sort();
    let l = a.len();
    if a[0] == 0 && a[l - 2] == 0 && a[l - 1] == 1 {
        for i in 0..l {
            if a0[i] == 1 {
                return Some(i);
            }
        }
    }
    None
}

fn specialpositions(a: Vec<Vec<u8>>) -> u32 {
    let mut vr = HashSet::new();
    let mut xs: HashSet<usize> = HashSet::new();
    for (y, row) in a.iter().enumerate() {
        if let Some(x) = validator(&row) {
            vr.insert((y, x));
            xs.insert(x);
        }
    }
    let mut xd: HashSet<usize> = HashSet::new();
    for &x in &xs {
        let c = a.iter().map(|r| r[x]).collect::<Vec<_>>();
        if let Some(_y) = validator(&c) {
        } else {
            xd.insert(x);
        }
    }
    xs = xs.difference(&xd).copied().collect();
    vr.into_iter().filter(|(_y, x)| xs.contains(&x)).count() as u32
}
