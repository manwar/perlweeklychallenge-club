#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(arraymedian(vec![2], vec![4]), 3.0);
}

#[test]
fn test_ex2() {
    assert_eq!(arraymedian(vec![1, 2, 3], vec![7, 8, 9, 10]), 7.0);
}

#[test]
fn test_ex3() {
    assert_eq!(arraymedian(Vec::<u32>::new(), vec![10, 20, 30, 40]), 25.0);
}

#[test]
fn test_ex4() {
    assert_eq!(arraymedian(vec![100], vec![1, 2, 3, 4, 5, 6, 7]), 4.5);
}

#[test]
fn test_ex5() {
    assert_eq!(arraymedian(vec![1, 2, 2], vec![2, 2, 3]), 2.0);
}

fn arraymedian(a: Vec<u32>, b: Vec<u32>) -> f64 {
    let mut nn = a.clone();
    for n in b {
        nn.push(n);
    }
    nn.sort_unstable();
    let i = nn.len() / 2;
    if nn.len().is_multiple_of(2) {
        ((nn[i - 1] + nn[i]) as f64) / 2.0
    } else {
        nn[i] as f64
    }
}
