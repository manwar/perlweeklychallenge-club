#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(percentageofcharacter("perl", 'e'), 25);
}

#[test]
fn test_ex2() {
    assert_eq!(percentageofcharacter("java", 'a'), 50);
}

#[test]
fn test_ex3() {
    assert_eq!(percentageofcharacter("python", 'm'), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(percentageofcharacter("ada", 'a'), 67);
}

#[test]
fn test_ex5() {
    assert_eq!(percentageofcharacter("ballerina", 'l'), 22);
}

#[test]
fn test_ex6() {
    assert_eq!(percentageofcharacter("analitik", 'k'), 13);
}

fn percentageofcharacter(a: &str, c: char) -> u8 {
    let d = a.len();
    let n = 100 * a.match_indices(c).count();
    ((n + d / 2) / d) as u8
}
