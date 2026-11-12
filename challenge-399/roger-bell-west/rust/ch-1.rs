#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(longestrepeatingcharacter("AAAAA", 2), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(longestrepeatingcharacter("ABCDE", 4), 5);
}

#[test]
fn test_ex3() {
    assert_eq!(longestrepeatingcharacter("AAABBBBAA", 1), 5);
}

#[test]
fn test_ex4() {
    assert_eq!(longestrepeatingcharacter("ABACADA", 2), 5);
}

#[test]
fn test_ex5() {
    assert_eq!(longestrepeatingcharacter("BAAABAAAA", 1), 8);
}

use std::cmp::max;
use std::collections::{HashSet, VecDeque};

fn lsub(wm: &Vec<char>, t: char) -> usize {
    let mut start = 0;
    let mut state = 0;
    let mut ll = Vec::new();
    for n in 0..wm.len() {
        if state == 0 {
            if wm[n] == t {
                start = n;
                state = 1;
            }
        } else {
            if wm[n] != t {
                ll.push(n - start);
                state = 0;
            }
        }
    }
    if state == 1 {
        ll.push(wm.len() - start);
    }
    *ll.iter().max().unwrap()
}

fn longestrepeatingcharacter(st: &str, k: usize) -> usize {
    let origin = st.chars().collect::<Vec<char>>();
    let targets = origin.iter().collect::<HashSet<_>>();
    let mut longestsub = 0;
    for t in targets {
        let mut queue: VecDeque<(Vec<char>, usize)> = VecDeque::new();
        queue.push_back((origin.clone(), 0));
        while let Some((wm, ct)) = queue.pop_front() {
            longestsub = max(longestsub, lsub(&wm, *t));
            if ct < k {
                let ctp = ct + 1;
                for n in 0..wm.len() {
                    if wm[n] != *t {
                        let mut wmp = wm.clone();
                        wmp[n] = *t;
                        queue.push_back((wmp, ctp));
                    }
                }
            }
        }
    }
    longestsub
}
