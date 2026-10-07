#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(alternatecase("aAbB"), 0);
}

#[test]
fn test_ex2() {
    assert_eq!(alternatecase("AAbb"), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(alternatecase("AAAbbb"), 3);
}

#[test]
fn test_ex4() {
    assert_eq!(alternatecase("aABb"), 1);
}

#[test]
fn test_ex5() {
    assert_eq!(alternatecase("bBBAaa"), 2);
}

use std::collections::VecDeque;

fn alternatecase(a: &str) -> usize {
    let uppers = a.chars().map(|c| c.is_uppercase()).collect::<Vec<_>>();
    let mut queue = VecDeque::new();
    queue.push_back((uppers, 0));
    while let Some((up, ct)) = queue.pop_front() {
        let mut swaps = Vec::new();
        for i in 0..up.len() - 1 {
            if up[i] == up[i + 1] {
                if i > 0 {
                    swaps.push(i - 1);
                }
                if i < up.len() - 2 {
                    swaps.push(i + 1);
                }
            }
        }
        if swaps.len() == 0 {
            return ct;
        }
        for sw in swaps {
            let mut uq = up.clone();
            (uq[sw], uq[sw + 1]) = (uq[sw + 1], uq[sw]);
            queue.push_back((uq, ct + 1));
        }
    }
    0
}
