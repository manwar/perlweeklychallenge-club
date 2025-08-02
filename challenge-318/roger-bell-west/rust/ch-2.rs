#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(reverseequals(vec![3, 2, 1, 4], vec![1, 2, 3, 4]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(reverseequals(vec![1, 3, 4], vec![4, 1, 3]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(reverseequals(vec![2], vec![2]), true);
}

fn reverseequals(a: Vec<i64>, b: Vec<i64>) -> bool {
    if a == b {
        return true;
    }
    for i in 0..a.len() - 1 {
        for j in i + 1..a.len() {
            let mut c = a.clone();
            for x in i..=j {
                c[x] = a[j - (x - i)]
            }
            if c == b {
                return true;
            }
        }
    }
    false
}
