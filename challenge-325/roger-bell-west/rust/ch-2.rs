#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(finalprice(vec![8, 4, 6, 2, 3]), vec![4, 2, 4, 2, 3]);
}

#[test]
fn test_ex2() {
    assert_eq!(finalprice(vec![1, 2, 3, 4, 5]), vec![1, 2, 3, 4, 5]);
}

#[test]
fn test_ex3() {
    assert_eq!(finalprice(vec![7, 1, 1, 5]), vec![6, 0, 1, 5]);
}

fn finalprice(a: Vec<i32>) -> Vec<i32> {
    let mut out = Vec::new();
    for (i, n) in a.iter().enumerate() {
        let mut discount = 0;
        for m in a.iter().skip(i + 1) {
            if m <= n {
                discount = *m;
                break;
            }
        }
        out.push(*n - discount);
    }
    out
}
