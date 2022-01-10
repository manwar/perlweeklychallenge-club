#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque, BTreeSet};
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(
        ltruncprimes(20),
        vec![
            2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137,
            167, 173, 197
        ]
    );
}

fn genprimes(mx: u32) -> Vec<u32> {
    let mut primesh: BTreeSet<u32> = BTreeSet::from_iter(2..=3);
    for i in (6..=mx+1).step_by(6) {
        for j in [i - 1, i + 1] {
            if j <= mx {
                primesh.insert(j);
            }
        }
    }
    let mut q = VecDeque::from([2, 3, 5, 7]);
    let mut p = q.pop_front().unwrap();
    let mr = (mx as f64).sqrt() as u32;
    while p <= mr {
        if primesh.contains(&p) {
            for i in (p * p..=mx).step_by(p as usize) {
                primesh.remove(&i);
            }
        }
        if q.len() < 2 {
            let t = q[0] + 4;
            q.push_back(t);
            q.push_back(t + 2);
        }
        p = q.pop_front().unwrap();
    }
    primesh.iter().map(|i| *i).collect::<Vec<u32>>()
}

fn ltruncprimes(count: usize) -> Vec<u32> {
    let mut out: Vec<u32> = Vec::new();
    let mut lt = 0;
    let p =
        genprimes(500).iter().map(|i| i.to_string()).collect::<Vec<String>>();
    let pp: HashSet<String> = HashSet::from_iter(p.clone());
    for pc in p {
        let l = pc.len() - 1;
        let mut c = true;
        for i in 1..=l {
            if !pp.contains(&pc[i..=l]) {
                c = false;
                break;
            }
        }
        if c {
            out.push(pc.parse::<u32>().unwrap());
            lt += 1;
            if lt >= count {
                break;
            }
        }
    }
    out
}
