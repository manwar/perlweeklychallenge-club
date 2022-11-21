#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::cmp::min;

#[test]
fn test_ex1() {
    assert_eq!(equaldistribution(vec![1, 0, 5]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(equaldistribution(vec![0, 2, 0]), -1);
}

#[test]
fn test_ex3() {
    assert_eq!(equaldistribution(vec![0, 3, 0]), 2);
}

fn equaldistribution(list: Vec<isize>) -> isize {
    let s = list.iter().sum::<isize>();
    let l = list.len() as isize;
    if s % l != 0 {
        return -1;
    }
    let m = s / l;
    let mut out = 0;
    let mut w = list.clone();
    loop {
        for i in 0..w.len() - 1 {
            if w[i] > m {
                let v = w[i] - m;
                w[i + 1] += v;
                out += v;
                w[i] = m;
            } else if w[i] < m {
                let v = min(m - w[i], w[i + 1]);
                w[i + 1] -= v;
                out += v;
                w[i] += v;
            }
        }
        let mut done = true;
        for v in &w {
            if *v != m {
                done = false;
                break;
            }
        }
        if done {
            break;
        }
    }
    out
}
