#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(rangelist(vec![1, 3, 4, 5, 7]), vec![vec![3, 5]]);
}

#[test]
fn test_ex2() {
    assert_eq!(rangelist(vec![1, 2, 3, 6, 7, 9]), vec![vec![1, 3], vec![6, 7]]);
}

#[test]
fn test_ex3() {
    assert_eq!(
        rangelist(vec![0, 1, 2, 4, 5, 6, 8, 9]),
        vec![vec![0, 2], vec![4, 6], vec![8, 9]]
    );
}

fn rangelist(l: Vec<isize>) -> Vec<Vec<isize>> {
    let mut o = Vec::new();
    let mut start = l[0];
    let mut prev = start;
    for &v in l.iter().skip(1) {
        if v != prev + 1 {
            if prev > start {
                o.push(vec![start, prev]);
            }
            start = v;
        }
        prev = v;
    }
    if prev > start {
        o.push(vec![start, prev]);
    }
    o
}
