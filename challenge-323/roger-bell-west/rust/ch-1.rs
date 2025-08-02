#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(incrementdecrement(vec!["--x", "x++", "x++"]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(incrementdecrement(vec!["x++", "++x", "x++"]), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(incrementdecrement(vec!["x++", "++x", "--x", "x--"]), 0);
}

fn incrementdecrement(operations: Vec<&str>) -> i32 {
    let mut p = 0;
    for s in operations {
        if s.chars().nth(1).unwrap() == '+' {
            p += 1;
        } else {
            p -= 1;
        }
    }
    p
}
