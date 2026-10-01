#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(pythagorasmultiplied(20), 12);
}

#[test]
fn test_ex2() {
    assert_eq!(pythagorasmultiplied(7), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(pythagorasmultiplied(1), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(pythagorasmultiplied(15), 8);
}

#[test]
fn test_ex5() {
    assert_eq!(pythagorasmultiplied(30), 22);
}

use std::collections::HashMap;

fn pythagorasmultiplied(n: u32) -> usize {
    let mut squared: HashMap<u32, u32> = HashMap::new();
    let mut ct = 0;
    for c in 5..=n {
        let csquared = *squared.entry(c).or_insert(c * c);
        for a in 1..=c - 2 {
            let asquared = *squared.entry(a).or_insert(a * a);
            for b in a + 1..=c - 1 {
                let bsquared = *squared.entry(b).or_insert(b * b);
                let tot = asquared + bsquared;
                if tot > csquared {
                    break;
                }
                if tot == csquared {
                    ct += 1;
                }
            }
        }
    }
    ct * 2
}
