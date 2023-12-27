#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        shortestdistance(vec![3, 2, 3, 2, 2, 2]),
        vec![vec![2, 2], vec![2, 2], vec![3, 3]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(shortestdistance(vec![1, 2, 3, 4]), Vec::<Vec<u32>>::new());
}

fn shortestdistance(a0: Vec<u32>) -> Vec<Vec<u32>> {
    if a0.len() % 2 != 0 {
        return Vec::new();
    }
    let mut a = a0.clone();
    a.sort();
    let mut out = Vec::new();
    for t in a.chunks(2) {
        if t[0] != t[1] {
            return Vec::new();
        }
        out.push(vec![t[0], t[0]]);
    }
    out
}
