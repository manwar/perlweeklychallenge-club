#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(stringscore("hello"), 13);
}

#[test]
fn test_ex2() {
    assert_eq!(stringscore("perl"), 30);
}

#[test]
fn test_ex3() {
    assert_eq!(stringscore("raku"), 37);
}

fn stringscore(a: &str) -> u32 {
    let mut out = 0;
    for i in a.chars().collect::<Vec<char>>().windows(2) {
        out += ((i[0] as i32) - (i[1] as i32)).abs();
    }
    out as u32
}
