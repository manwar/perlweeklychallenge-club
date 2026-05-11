#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(largestsubstring("aaaaa"), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(largestsubstring("abcdeba"), 5);
}

#[test]
fn test_ex3() {
    assert_eq!(largestsubstring("abbc"), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(largestsubstring("abcaacbc"), 4);
}

#[test]
fn test_ex5() {
    assert_eq!(largestsubstring("laptop"), 2);
}

fn largestsubstring(a: &str) -> isize {
    let cc = a.chars().collect::<Vec<_>>();
    for offset in (1..cc.len()).rev() {
        for x in 0..cc.len() - offset {
            if cc[x] == cc[x + offset] {
                return (offset - 1) as isize;
            }
        }
    }
    -1
}
