#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, HashSet};

#[test]
fn test_ex1() {
    assert_eq!(
        busroute(vec![vec![12, 11, 41], vec![15, 5, 35]]),
        vec![36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        busroute(vec![vec![12, 3, 41], vec![15, 9, 35], vec![30, 5, 25]]),
        vec![
            0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
            51, 55, 56, 57, 58, 59
        ]
    );
}

fn busroute(a: Vec<Vec<u32>>) -> Vec<u32> {
    let mut routes = Vec::new();
    for rt in a {
        let mut ri = HashMap::new();
        let interval = rt[0];
        let offset = rt[1];
        let duration = rt[2];
        let mut start = offset;
        while start <= 60 + offset {
            ri.insert(start, start + duration);
            start += interval;
        }
        routes.push(ri);
    }
    let mut out = Vec::new();
    for t in 0..60 {
        let mut best = HashSet::new();
        let mut at: Option<u32> = None;
        let mut nxt = HashSet::new();
        let mut ndt: Option<u32> = None;
        for (i, r) in routes.iter().enumerate() {
            let nb = r.keys().filter(|n| **n >= t).min().unwrap();
            let nt = r.get(nb).unwrap();
            if at.is_none() || *nt < at.unwrap() {
                best.clear();
                at = Some(*nt);
            }
            if *nt <= at.unwrap() {
                best.insert(i);
            }
            if ndt.is_none() || *nb < ndt.unwrap() {
                nxt.clear();
                ndt = Some(*nb);
            }
            if *nb <= ndt.unwrap() {
                nxt.insert(i);
            }
        }
        if best.intersection(&nxt).count() == 0 {
            out.push(t);
        }
    }
    out
}
