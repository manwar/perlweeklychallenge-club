#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(contiguousarray(vec![1, 0]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(contiguousarray(vec![0, 1, 0]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(contiguousarray(vec![0, 0, 0, 0, 0]), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(contiguousarray(vec![0, 1, 0, 0, 1, 0]), 4);
}

fn contiguousarray(a: Vec<usize>) -> usize {
    for l in (2..a.len() + 1).step_by(2).rev() {
        for start in 0..=a.len() - l {
            let end = start + l - 1;
            if a[start..=end].iter().sum::<usize>() * 2 == l {
                return l;
            }
        }
    }
    0
}
