#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        minabsdiff(vec![4, 2, 1, 3]),
        vec![vec![1, 2], vec![2, 3], vec![3, 4]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        minabsdiff(vec![10, 100, 20, 30]),
        vec![vec![10, 20], vec![20, 30]]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(minabsdiff(vec![-5, -2, 0, 3]), vec![vec![-2, 0]]);
}

#[test]
fn test_ex4() {
    assert_eq!(minabsdiff(vec![8, 1, 15, 3]), vec![vec![1, 3]]);
}

#[test]
fn test_ex5() {
    assert_eq!(
        minabsdiff(vec![12, 5, 9, 1, 15]),
        vec![vec![9, 12], vec![12, 15]]
    );
}

fn minabsdiff(a: Vec<i32>) -> Vec<Vec<i32>> {
    let mut b = a.clone();
    b.sort();
    let mut out = Vec::new();
    let mut mindiff = 1 + b[b.len() - 1] - b[0];
    for c in b.windows(2) {
        let d = c[1] - c[0];
        if d < mindiff {
            out.clear();
            mindiff = d;
        }
        if d == mindiff {
            out.push(c.to_vec());
        }
    }
    out
}
