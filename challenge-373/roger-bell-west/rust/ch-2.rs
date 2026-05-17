#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(listdivision(vec![1, 2, 3, 4, 5], 2), vec![vec![1, 2, 3], vec![4, 5]]);
}

#[test]
fn test_ex2() {
    assert_eq!(listdivision(vec![1, 2, 3, 4, 5, 6], 3), vec![vec![1, 2], vec![3, 4], vec![5, 6]]);
}

#[test]
fn test_ex3() {
    assert_eq!(listdivision(vec![1, 2, 3], 2), vec![vec![1, 2], vec![3]]);
}

#[test]
fn test_ex4() {
    assert_eq!(listdivision(vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5), vec![vec![1, 2], vec![3, 4], vec![5, 6], vec![7, 8], vec![9, 10]]);
}

#[test]
fn test_ex5() {
    assert_eq!(listdivision(vec![1, 2, 3], 4), Vec::<Vec<u32>>::new());
}

fn listdivision(a: Vec<u32>, n: usize) -> Vec<Vec<u32>> {
    if n > a.len() {
        return Vec::<Vec<u32>>::new();
    }
    let mut divsize = vec![a.len() / n; n];
    for i in 0 .. a.len() % n {
        divsize[i] += 1;
    }
    let mut out = Vec::new();
    let mut x = 0;
    for s in divsize {
        out.push(a[x .. (x + s)].to_vec());
        x += s;
    }
    out
}
