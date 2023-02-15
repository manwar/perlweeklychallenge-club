#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(reshapematrix(vec![vec![1, 2], vec![3, 4]], 1, 4), vec![vec![1, 2, 3, 4]]);
}

#[test]
fn test_ex2() {
    assert_eq!(reshapematrix(vec![vec![1, 2, 3], vec![4, 5, 6]], 3, 2), vec![vec![1, 2], vec![3, 4], vec![5, 6]]);
}

#[test]
fn test_ex3() {
    assert_eq!(reshapematrix(vec![vec![1, 2]], 3, 2), vec![vec![0]]);
}

fn reshapematrix(m: Vec<Vec<i32>>, r: usize, c: usize) -> Vec<Vec<i32>> {
    let mv = m.into_iter().flatten().collect::<Vec<i32>>();
    if r * c != mv.len() {
        return vec![vec![0]];
    }
    let mut out = Vec::new();
    for i in 0..r {
        out.push(mv[i * c .. (i + 1) * c].to_vec());
    }
    out
}
