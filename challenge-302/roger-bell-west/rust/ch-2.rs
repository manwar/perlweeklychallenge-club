#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(stepbystep(vec![-3, 2, -3, 4, 2]), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(stepbystep(vec![1, 2]), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(stepbystep(vec![1, -2, -3]), 5);
}

fn stepbystep(a: Vec<i32>) -> i32 {
    let mut mv = 0;
    let mut tot = 0;
    for s in a {
        tot += s;
        if mv > tot {
            mv = tot;
        }
    }
    1 - mv
}
