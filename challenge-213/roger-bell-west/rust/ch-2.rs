#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashMap, HashSet, VecDeque};

#[test]
fn test_ex1() {
    assert_eq!(
        shortestroute(vec![vec![1, 2, 6], vec![5, 6, 7]], 1, 7),
        vec![1, 2, 6, 7]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        shortestroute(vec![vec![1, 2, 3], vec![4, 5, 6]], 2, 5),
        Vec::<u32>::new()
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        shortestroute(
            vec![vec![1, 2, 3], vec![4, 5, 6], vec![3, 8, 9], vec![7, 8]],
            1,
            7
        ),
        vec![1, 2, 3, 8, 7]
    );
}

fn shortestroute(r0: Vec<Vec<u32>>, origin: u32, destination: u32) -> Vec<u32> {
    let mut r: HashMap<u32, HashSet<u32>> = HashMap::new();
    for rt in r0 {
        for rp in rt.windows(2) {
            r.entry(rp[0])
                .and_modify(|s| {
                    (*s).insert(rp[1]);
                })
                .or_insert(HashSet::from([rp[1]]));
            r.entry(rp[1])
                .and_modify(|s| {
                    (*s).insert(rp[0]);
                })
                .or_insert(HashSet::from([rp[0]]));
        }
    }
    let mut out = Vec::new();
    let mut stack = VecDeque::new();
    stack.push_back((vec![origin], HashSet::from([origin])));
    while stack.len() > 0 {
        let s = stack.pop_front().unwrap();
        let l = s.0.last().unwrap();
        if *l == destination {
            out = s.0;
            break;
        } else {
            for pd in r.get(&l).unwrap().difference(&s.1) {
                let mut q = s.clone();
                q.0.push(*pd);
                q.1.remove(pd);
                stack.push_back(q);
            }
        }
    }
    out
}
