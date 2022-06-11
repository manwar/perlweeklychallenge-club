#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(
        farey(5),
        vec![
            [0, 1],
            [1, 5],
            [1, 4],
            [1, 3],
            [2, 5],
            [1, 2],
            [3, 5],
            [2, 3],
            [3, 4],
            [4, 5],
            [1, 1]
        ]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        farey(7),
        vec![
            [0, 1],
            [1, 7],
            [1, 6],
            [1, 5],
            [1, 4],
            [2, 7],
            [1, 3],
            [2, 5],
            [3, 7],
            [1, 2],
            [4, 7],
            [3, 5],
            [2, 3],
            [5, 7],
            [3, 4],
            [4, 5],
            [5, 6],
            [6, 7],
            [1, 1]
        ]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        farey(4),
        vec![[0, 1], [1, 4], [1, 3], [1, 2], [2, 3], [3, 4], [1, 1]]
    );
}

fn gcd(m0: usize, n0: usize) -> usize {
    let mut m = m0;
    let mut n = n0;
    while n != 0 {
        let t = n;
        n = m % n;
        m = t;
    }
    m
}

fn lcm(m: usize, n: usize) -> usize {
    m / gcd(m, n) * n
}

fn lcmseries(s: Vec<usize>) -> usize {
    s.iter().fold(1, |acc, x| lcm(acc, *x))
}

fn farey(n: usize) -> Vec<[usize; 2]> {
    let l = lcmseries((2..=n).collect::<Vec<usize>>());
    let mut d: HashMap<usize, [usize; 2]> = HashMap::new();
    let mut s = Vec::new();
    for i in 1..=n {
        let m = l / i;
        for j in 0..=i {
            let k = m * j;
            if !d.contains_key(&k) {
                d.insert(k, [j, i]);
                s.push(k);
            }
        }
    }
    s.sort();
    return s.iter().map(|i| d[i]).collect::<Vec<[usize; 2]>>();
}
