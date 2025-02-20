#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(mindiff(vec![1, 5, 8, 9]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(mindiff(vec![9, 4, 1, 7]), 2);
}

fn mindiff(a: Vec<i32>) -> i32 {
    let mut md = 0;
    let mut n = false;
    for i in 0 .. a.len() - 1 {
        for j in i + 1 .. a.len() {
            let diff = (a[i] - a[j]).abs();
            if !n || diff < md {
                md = diff;
                n = true;
            }
        }
    }
    md
}
