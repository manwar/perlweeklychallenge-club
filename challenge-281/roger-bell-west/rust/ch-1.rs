#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(checkcolor("d3"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(checkcolor("g5"), false);
}

#[test]
fn test_ex3() {
    assert_eq!(checkcolor("e6"), true);
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
