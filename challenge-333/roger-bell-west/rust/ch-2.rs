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
    assert_eq!(duplicatezeros(vec![1, 2, 3, 0]), vec![1, 2, 3, 0]);
}

#[test]
fn test_ex4() {
    assert_eq!(duplicatezeros(vec![0, 0, 1, 2]), vec![0, 0, 0, 0]);
}

#[test]
fn test_ex5() {
    assert_eq!(duplicatezeros(vec![1, 2, 0, 3, 4]), vec![1, 2, 0, 0, 3]);
}

fn duplicatezeros(a: Vec<u32>) -> Vec<u32> {
    let mut b = Vec::new();
    for n in &a {
        b.push(*n);
        if a.len() == b.len() {
            break;
        }
        if *n == 0 {
            b.push(0);
            if a.len() == b.len() {
                break;
            }
        }
    }
    b
}
