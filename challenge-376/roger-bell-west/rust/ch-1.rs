#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(chessboardsquares("a7", "f4"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(chessboardsquares("c1", "e8"), false);
}

#[test]
fn test_ex3() {
    assert_eq!(chessboardsquares("b5", "h2"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(chessboardsquares("f3", "h1"), true);
}

#[test]
fn test_ex5() {
    assert_eq!(chessboardsquares("a1", "g8"), false);
}

fn cs2xy(a: &str) -> (u8, u8) {
    let c = a.chars().collect::<Vec<char>>();
    let x = c[0] as u8 - 'a' as u8;
    let y = c[1] as u8 - '1' as u8;
    (x, y)
}

fn checkcolor(a: &str) -> bool {
    let xy = cs2xy(a);
    (xy.0 + xy.1) % 2 == 1
}

fn chessboardsquares(a: &str, b: &str) -> bool {
    checkcolor(a) == checkcolor(b)
}
