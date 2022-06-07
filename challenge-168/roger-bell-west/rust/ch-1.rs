#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};

#[test]
fn test_ex1() {
    assert_eq!(
        perrinprime(13),
        vec![
            2,
            3,
            5,
            7,
            17,
            29,
            277,
            367,
            853,
            14197,
            43721,
            1442968193,
            792606555396977
        ]
    );
}

fn isprime(candidate: usize) -> bool {
    if candidate < 2 {
        return false;
    } else if candidate == 2 {
        return true;
    } else if candidate == 3 {
        return true;
    } else if candidate % 2 == 0 {
        return false;
    } else if candidate % 3 == 0 {
        return false;
    }
    let mut anchor = 0usize;
    let limit = (candidate as f64).sqrt() as usize;
    loop {
        anchor += 6;
        for t in [anchor - 1, anchor + 1].iter() {
            if *t > limit {
                return true;
            }
            if candidate % *t == 0 {
                return false;
            }
        }
    }
}

fn perrinprime(n: usize) -> Vec<usize> {
    let mut out: HashSet<usize> = HashSet::new();
    let mut seq = VecDeque::from([3, 0, 2]);
    loop {
        let nv = seq[0] + seq[1];
        seq.pop_front();
        seq.push_back(nv);
        if isprime(nv) {
            out.insert(nv);
            if out.len() >= n {
                break;
            }
        }
    }
    let mut o = out.drain().collect::<Vec<usize>>();
    o.sort();
    o
}
