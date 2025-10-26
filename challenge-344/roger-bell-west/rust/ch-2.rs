#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        arrayformation(vec![vec![2, 3], vec![1], vec![4]], vec![1, 2, 3, 4]),
        true
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        arrayformation(vec![vec![1, 3], vec![2, 4]], vec![1, 2, 3, 4]),
        false
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        arrayformation(
            vec![vec![9, 1], vec![5, 8], vec![2]],
            vec![5, 8, 2, 9, 1]
        ),
        true
    );
}

#[test]
fn test_ex4() {
    assert_eq!(arrayformation(vec![vec![1], vec![3]], vec![1, 2, 3]), false);
}

#[test]
fn test_ex5() {
    assert_eq!(arrayformation(vec![vec![7, 4, 6]], vec![7, 4, 6]), true);
}

use std::collections::HashSet;

fn arrayformation(src: Vec<Vec<i32>>, tgt: Vec<i32>) -> bool {
    let mut stack: Vec<(Vec<i32>, HashSet<usize>)> = Vec::new();
    stack.push((
        Vec::new(),
        (0..src.len()).into_iter().collect::<HashSet<usize>>(),
    ));
    while let Some(c) = stack.pop() {
        if c.0.len() == tgt.len() {
            return true;
        } else {
            for candidate in &c.1 {
                let offset = c.0.len();
                let mut nextcandidate = c.1.clone();
                nextcandidate.remove(&candidate);
                let mut valid = true;
                let mut seq = c.0.clone();
                for (i, x) in src[*candidate].iter().enumerate() {
                    if *x == tgt[i + offset] {
                        seq.push(*x);
                    } else {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    stack.push((seq, nextcandidate));
                }
            }
        }
    }
    false
}
