#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        duplicatezeros(vec![1, 0, 2, 3, 0, 4, 5, 0]),
        vec![1, 0, 0, 2, 3, 0, 0, 4]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(duplicatezeros(vec![1, 2, 3]), vec![1, 2, 3]);
}

#[test]
fn test_ex3() {
    assert_eq!(duplicatezeros(vec![0, 3, 0, 4, 5]), vec![0, 0, 3, 0, 0]);
}

fn duplicatezeros(a: Vec<u32>) -> Vec<u32> {
    let mut out = Vec::new();
    for t in &a {
        out.push(*t);
        if *t == 0 {
            out.push(*t);
        }
        if out.len() >= a.len() {
            break;
        }
    }
    out.resize(a.len(), out[0]);
    out
}
