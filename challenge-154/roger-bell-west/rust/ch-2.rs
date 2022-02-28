#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        padovanprime(10),
        vec![2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057]
    );
}

fn padovanprime(ct: usize) -> Vec<u64> {
    let mut pp: HashSet<u64> = HashSet::new();
    let mut padovans: [u64; 4] = [1; 4];
    loop {
        padovans[3] = padovans[0] + padovans[1];
        for i in 0..=2 {
            padovans[i] = padovans[i + 1];
        }
        if isprime(padovans[3]) {
            pp.insert(padovans[3]);
            if pp.len() >= ct {
                break;
            }
        }
    }
    let mut out: Vec<u64> = pp.iter().map(|i| *i).collect::<Vec<u64>>();
    out.sort();
    return out;
}

fn isprime(candidate: u64) -> bool {
    if candidate == 2 {
        return true;
    } else if candidate == 3 {
        return true;
    } else if candidate % 2 == 0 {
        return false;
    } else if candidate % 3 == 0 {
        return false;
    }
    let mut anchor = 0u64;
    let limit = (candidate as f64).sqrt() as u64;
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
