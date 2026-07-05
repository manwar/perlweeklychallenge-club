#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(reversedegree("z"), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(reversedegree("a"), 26);
}

#[test]
fn test_ex3() {
    assert_eq!(reversedegree("bbc"), 147);
}

#[test]
fn test_ex4() {
    assert_eq!(reversedegree("racecar"), 560);
}

#[test]
fn test_ex5() {
    assert_eq!(reversedegree("zyx"), 14);
}

fn reversedegree(a: &str) -> u32 {
    let mut t = 0;
    let z0 = 'z' as u32 + 1;
    for (i, c) in a.chars().enumerate() {
        t += (z0 - c as u32) * (1 + i as u32);
    }
    t
}
