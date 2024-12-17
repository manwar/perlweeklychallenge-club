#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(beautifularrangement(2), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(beautifularrangement(1), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(beautifularrangement(10), 700);
}

#[test]
fn test_ex4() {
    assert_eq!(beautifularrangement(20), 1939684);
}

fn beautifularrangement(a: usize) -> usize {
    let mut precalc = vec![vec![false; a + 1]; a + 1];
    for i in 1..=a {
        for j in (i..=a).step_by(i) {
            precalc[i][j] = true;
            precalc[j][i] = true;
        }
    }
    let mut ct = 0;
    let mut stack = Vec::new();
    stack.push(Vec::from_iter(1..=a));
    while let Some(trail) = stack.pop() {
        if trail.len() == 1 {
            ct += 1;
        } else {
            let p = a - trail.len() + 2;
            for i in &trail {
                if precalc[*i][p] {
                    let tt = trail
                        .iter()
                        .filter(|x| *x != i)
                        .copied()
                        .collect::<Vec<usize>>();
                    stack.push(tt);
                }
            }
        }
    }
    ct
}
