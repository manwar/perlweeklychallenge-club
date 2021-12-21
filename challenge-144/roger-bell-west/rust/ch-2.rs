#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(ulam(1, 2, 10), vec![1, 2, 3, 4, 6, 8, 11, 13, 16, 18]);
}

#[test]
fn test_ex2() {
    assert_eq!(ulam(2, 3, 10), vec![2, 3, 5, 7, 8, 9, 13, 14, 18, 19]);
}

#[test]
fn test_ex3() {
    assert_eq!(ulam(2, 5, 10), vec![2, 5, 7, 9, 11, 12, 13, 15, 19, 23]);
}

fn ulam(u: usize, v: usize, count: usize) -> Vec<usize> {
    let mut ulams = Vec::from([u, v]);
    let mut sieve = vec![];
    let mut uc = v;
    while ulams.len() < count {
        sieve.extend(vec![0; uc + ulams[ulams.len() - 2] - sieve.len()]);
        for i in 0..=ulams.len() - 2 {
            sieve[uc + ulams[i] - 1] += 1;
        }
        for i in uc..sieve.len() {
            if sieve[i] == 1 {
                uc = i + 1;
                ulams.push(uc);
                break;
            }
        }
    }
    ulams
}
