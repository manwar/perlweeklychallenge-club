#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(binarydate("2025-07-26"), "11111101001-111-11010");
}

#[test]
fn test_ex2() {
    assert_eq!(binarydate("2000-02-02"), "11111010000-10-10");
}

#[test]
fn test_ex3() {
    assert_eq!(binarydate("2024-12-31"), "11111101000-1100-11111");
}

fn binarydate(a: &str) -> String {
    a.split('-')
        .map(|n| format!("{:0b}", n.parse::<u32>().unwrap()))
        .collect::<Vec<_>>()
        .join("-")
}
