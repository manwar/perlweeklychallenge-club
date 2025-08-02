#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(twodarray(vec![1, 2, 3, 4], 2, 2), vec![vec![1, 2], vec![3, 4]]);
}

#[test]
fn test_ex2() {
    assert_eq!(twodarray(vec![1, 2, 3], 1, 3), vec![vec![1, 2, 3]]);
}

#[test]
fn test_ex3() {
    assert_eq!(twodarray(vec![1, 2, 3, 4], 4, 1), vec![vec![1], vec![2], vec![3], vec![4]]);
}

fn twodarray(i: Vec<i32>, _r: usize, c: usize) -> Vec<Vec<i32>> {
    let mut out = Vec::new();
    for (ct, n) in i.into_iter().enumerate() {
        if ct % c == 0 {
            out.push(Vec::new());
        }
        let ol = out.len() - 1;
        out[ol].push(n);
    }
    out
}
