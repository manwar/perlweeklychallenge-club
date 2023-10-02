#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(lastmember(vec![2, 7, 4, 1, 8, 1]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(lastmember(vec![1]), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(lastmember(vec![1, 1]), 0);
}

fn lastmember(a0: Vec<u32>) -> u32 {
    let mut a = a0.clone();
    while a.len() > 1 {
        a.sort();
        let x = a.pop().unwrap();
        let y = a.pop().unwrap();
        if x > y {
            a.push(x - y);
        }
    }
    if a.len() == 0 {
        0
    } else {
        a[0]
    }
}
