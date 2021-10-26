#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(fibseq(16),4);
}

#[test]
fn test_ex2() {
    assert_eq!(fibseq(9),2);
}

#[test]
fn test_ex3() {
    assert_eq!(fibseq(15),2);
}

fn f (x: i32,y: i32,z: i32) -> i32 {
    if x<y {
        return if x==0 { 1 } else { 0 };
    } else {
        return f(x-y,y+z,y)+f(x,y+z,y);
    }
}

fn fibseq(m: i32) -> i32 {
    f(m,1,1)
}
