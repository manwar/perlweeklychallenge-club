#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(m3d(1234567),"345");
}

#[test]
fn test_ex2() {
    assert_eq!(m3d(-123),"123".to_string());
}

#[test]
fn test_ex3() {
    assert_eq!(m3d(1),"too short".to_string());
}

#[test]
fn test_ex4() {
    assert_eq!(m3d(1010),"even number of digits".to_string());
}

fn m3d(n: i32) -> String {
    let m=n.abs().to_string();
    let l=m.len();
    if l < 3 {
        return "too short".to_string();
    }
    if l % 2 == 0 {
        return "even number of digits".to_string();
        }
    let i=l/2-1;
    m[i..i+3].to_string()
}
