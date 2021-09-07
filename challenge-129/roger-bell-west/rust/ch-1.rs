#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1a() {
    assert_eq!(rd(vec![
        1,
        2,      3,
        0,  0,  0,  4,
        0,0,0,0,0,0,5,6
    ],6),3);
}

#[test]
fn test_ex1b() {
    assert_eq!(rd(vec![
        1,
        2,      3,
        0,  0,  0,  4,
        0,0,0,0,0,0,5,6
    ],5),3);
}

#[test]
fn test_ex1c() {
    assert_eq!(rd(vec![
        1,
        2,      3,
        0,  0,  0,  4,
        0,0,0,0,0,0,5,6
    ],2),1);
}

#[test]
fn test_ex1d() {
    assert_eq!(rd(vec![
        1,
        2,      3,
        0,  0,  0,  4,
        0,0,0,0,0,0,5,6
    ],4),2);
}

#[test]
fn test_ex2a() {
    assert_eq!(rd(vec![
        1,
        2,              3,
        4,      0,      0,      5,
        0,  6,  0,  0,  0,  0,  7,  0,
        0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
    ],7),3);
}

#[test]
fn test_ex2b() {
    assert_eq!(rd(vec![
        1,
        2,              3,
        4,      0,      0,      5,
        0,  6,  0,  0,  0,  0,  7,  0,
        0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
    ],8),4);
}

#[test]
fn test_ex2c() {
    assert_eq!(rd(vec![
        1,
        2,              3,
        4,      0,      0,      5,
        0,  6,  0,  0,  0,  0,  7,  0,
        0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
    ],6),3);
}

fn rd(tree: Vec<u64>,content: u64) -> i64 {
    let mut depth: i64=0;
    let mut dl: u64=1;
    let mut db: u64=1;
    for i in 0..tree.len() {
        if tree[i]==content {
            return depth;
        }
        dl -= 1;
        if dl==0 {
            db *= 2;
            dl = db;
            depth += 1;
        }
    }
    return -1;
}
