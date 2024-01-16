#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(luckynumbers(vec![vec![3, 7, 9], vec![9, 11, 13], vec![15, 16, 17]]), 15);
}

#[test]
fn test_ex2() {
    assert_eq!(luckynumbers(vec![vec![1, 10, 4, 2], vec![9, 3, 8, 7], vec![15, 16, 17, 12]]), 12);
}

#[test]
fn test_ex3() {
    assert_eq!(luckynumbers(vec![vec![7, 8], vec![1, 2]]), 7);
}

fn luckynumbers(a: Vec<Vec<i32>>) -> i32 {
    let mut maxs = HashSet::new();
    for x in 0 .. a[0].len() {
        let mut max = (0, 0, 0);
        for y in 0 .. a.len() {
            if a[y][x] > max.0 {
                max = (a[y][x], y, x);
            }
        }
        maxs.insert(max);
    }
    let mut mins = HashSet::new();
    for y in 0 .. a.len() {
        let mut min = (a[y][0], y, 0);
        for x in 0 .. a[0].len() {
            if a[y][x] < min.0 {
                min = (a[y][x], y, x);
            }
        }
        mins.insert(min);
    }
    let i = maxs.intersection(&mins).collect::<Vec<_>>();
    if i.len() > 0 {
        return i[0].0;
    }
    -1
}
