#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(divisibleaverage(vec![18, 5, 7, 11]), 18);
}

#[test]
fn test_ex2() {
    assert_eq!(divisibleaverage(vec![6, 12, 18, 24, 30, 40]), 18);
}

#[test]
fn test_ex3() {
    assert_eq!(divisibleaverage(vec![3, 9, 15, 21, 27]), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(divisibleaverage(vec![6, 12, 14, 20]), 9);
}

#[test]
fn test_ex5() {
    assert_eq!(divisibleaverage(vec![6, 6, 6, 12, 12]), 8);
}

fn divisibleaverage(a: Vec<u32>) -> u32 {
    let b = a.into_iter().filter(|x| x.is_multiple_of(6)).collect::<Vec<u32>>();
    if b.len() == 0 {
        return 0;
    }
    ((b.iter().sum::<u32>() as f64) / (b.len() as f64) + 0.5) as u32
}
