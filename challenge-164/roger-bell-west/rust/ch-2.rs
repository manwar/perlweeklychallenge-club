#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, HashMap};

#[test]
fn test_ex1() {
    assert_eq!(happy(8), vec![1, 7, 10, 13, 19, 23, 28, 31]);
}

fn ssd(n0: usize) -> usize {
    let mut n = n0;
    let mut out = 0;
    while n > 0 {
        let d = n % 10;
        out += d * d;
        n /= 10;
    }
    out
}

fn happy(ct: usize) -> Vec<usize> {
    let mut hm: HashMap<usize, bool> = HashMap::from([(1, true)]);
    let mut c = 0;
    let mut out = Vec::new();
    loop {
        c += 1;
        if !hm.contains_key(&c) {
            let mut v = c;
            let mut ss: HashSet<usize> = HashSet::from([v]);
            let h;
            loop {
                if hm.contains_key(&v) {
                    h = *hm.get(&v).unwrap();
                    break;
                } else {
                    v = ssd(v);
                    if ss.contains(&v) {
                        h = false;
                        break;
                    }
                    ss.insert(v);
                }
            }
            for i in ss {
                hm.insert(i,h);
            }
        }
        if *hm.get(&c).unwrap() {
            out.push(c);
            if out.len() >= ct {
                break;
            }
        }
    }
    out
}
