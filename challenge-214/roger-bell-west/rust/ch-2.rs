#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::cmp::max;

#[test]
fn test_ex1() {
    assert_eq!(collectpoints(vec![2, 4, 3, 3, 3, 4, 5, 4, 2]), 23);
}

#[test]
fn test_ex2() {
    assert_eq!(collectpoints(vec![1, 2, 2, 2, 2, 1]), 20);
}

#[test]
fn test_ex3() {
    assert_eq!(collectpoints(vec![1]), 1);
}

#[test]
fn test_ex4() {
    assert_eq!(collectpoints(vec![2, 2, 2, 1, 1, 2, 2, 2]), 40);
}

fn collectpoints(a: Vec<i32>) -> u32 {
    let mut m: Vec<(i32, u32)> = Vec::new();
    let mut s = 0;
    while s < a.len() {
        let k = a[s];
        let mut e = s;
        while e < a.len() && a[e] == k {
            e += 1;
        }
        m.push((k, (e - s) as u32));
        s = e;
    }
    let mut rv = 0;
    let mut stack: Vec<(Vec<(i32, u32)>, u32)> = Vec::new();
    stack.push((m, 0));
    while stack.len() > 0 {
        let s = stack.pop().unwrap();
        if s.0.len() == 0 {
            rv = max(rv, s.1);
        } else {
            for i in 0..s.0.len() {
                let mut ss = s.clone();
                ss.1 += ss.0[i].1 * ss.0[i].1;
                ss.0.remove(i);
                let mut j = i;
                loop {
                    if j > 0 && j < ss.0.len() && ss.0[j].0 == ss.0[j - 1].0 {
                        ss.0[j].1 += ss.0[j - 1].1;
                        ss.0.remove(j - 1);
                        j -= 1;
                    } else {
                        break;
                    }
                }
                stack.push(ss);
            }
        }
    }
    rv
}
