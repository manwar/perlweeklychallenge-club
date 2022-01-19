#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashSet;
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(
        semiprime(100),
        vec![
            4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46, 49,
            51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95
        ]
    );
}

fn semiprime(mx: u32) -> Vec<u32> {
    let mxx = mx / 2;
    let mut primesh: HashSet<u32> = HashSet::from_iter(2..=mxx);
    let mut p = 2;
    while p * p <= mxx {
        if primesh.contains(&p) {
            for i in (p * p..=mxx).step_by(p as usize) {
                primesh.remove(&i);
            }
        }
        if p == 2 {
            p -= 1;
        }
        p += 2;
    }
    let mut primes = primesh.iter().map(|i| *i).collect::<Vec<u32>>();
    primes.sort();
    let mut semiprimesh: HashSet<u32> = HashSet::new();
    for i in 0..primes.len() {
        for j in i..primes.len() {
            let t = primes[i] * primes[j];
            if t < mx {
                semiprimesh.insert(t);
            } else {
                break;
            }
        }
    }
    let mut semiprimes = semiprimesh.iter().map(|i| *i).collect::<Vec<u32>>();
    semiprimes.sort();
    semiprimes
}
