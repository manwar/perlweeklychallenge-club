#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(duplicateandmissing(vec![1, 2, 2, 4]), vec![2, 3]);
}

#[test]
fn test_ex2() {
    assert_eq!(duplicateandmissing(vec![1, 2, 3, 4]), vec![-1]);
}

#[test]
fn test_ex3() {
    assert_eq!(duplicateandmissing(vec![1, 2, 3, 3]), vec![3, 4]);
}

fn duplicateandmissing(a: Vec<isize>) -> Vec<isize> {
    let mut flags = 0;
    let mut dup = 0;
    let mut mis = 0;
    let mut exp = a[0] + 1;
    for n in a.iter().skip(1) {
        if *n < exp {
            dup = *n;
            flags |= 1;
        } else if *n > exp {
            mis = exp;
            flags |= 2;
        }
        if flags == 3 {
            return vec![dup, mis];
        }
        exp = *n + 1;
    }
    if flags == 1 {
        return vec![dup, exp];
    }
    return vec![-1];
}
