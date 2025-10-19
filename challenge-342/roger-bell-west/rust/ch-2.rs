#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maxscore("0011"), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(maxscore("0000"), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(maxscore("1111"), 3);
}

#[test]
fn test_ex4() {
    assert_eq!(maxscore("0101"), 3);
}

#[test]
fn test_ex5() {
    assert_eq!(maxscore("011101"), 5);
}

fn maxscore(a: &str) -> usize {
    let mut zeroestoleft = 0;
    let mut onestoright = a.len();
    let mut maxscore = 0;
    for (i, c) in a.chars().enumerate() {
        match c {
            '0' => zeroestoleft += 1,
            '1' => onestoright -= 1,
            _ => ()
        };
        if i + 1 < a.len() {
            maxscore = std::cmp::max(maxscore, zeroestoleft + onestoright);
        }
    }
    maxscore - onestoright
}
