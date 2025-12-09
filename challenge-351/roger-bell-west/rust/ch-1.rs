#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(specialaverage(vec![8000, 5000, 6000, 2000, 3000, 7000]), 5250);
}

#[test]
fn test_ex2() {
    assert_eq!(specialaverage(vec![100000, 80000, 110000, 90000]), 95000);
}

#[test]
fn test_ex3() {
    assert_eq!(specialaverage(vec![2500, 2500, 2500, 2500]), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(specialaverage(vec![2000]), 0);
}

#[test]
fn test_ex5() {
    assert_eq!(specialaverage(vec![1000, 2000, 3000, 4000, 5000, 6000]), 3500);
}

fn specialaverage(a0: Vec<u32>) -> u32 {
    let mut a = a0.clone();
    a.sort();
    let min = a[0];
    let max = a[a.len() - 1];
    let b = a
        .iter()
        .filter(|x| **x != min && **x != max)
        .copied()
        .collect::<Vec<u32>>();
    if b.len() == 0 {
        return 0;
    }
    b.iter().sum::<u32>() / (b.len() as u32)
}
