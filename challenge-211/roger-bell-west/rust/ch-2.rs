#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(splitsameaverage(vec![1, 2, 3, 4, 5, 6, 7, 8]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(splitsameaverage(vec![1, 3]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(splitsameaverage(vec![1, 2, 3]), true);
}

fn splitsameaverage(a: Vec<i32>) -> bool {
    let ss = a.iter().sum::<i32>();
    let ml = a.len();
    let mx = ml / 2;
    let mut ssa = false;
    for n in 1 ..= mx {
        for c in a.iter().combinations(n) {
            let ca = c.iter().map(|i| *i).sum::<i32>();
            if (ca as f64) / (n as f64) == ((ss - ca) as f64) / ((ml - n) as f64) {
                ssa = true;
                break;
            }
        }
        if ssa {
            break;
        }
    }
    ssa
}
