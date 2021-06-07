#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sos(34),1);
}

#[test]
fn test_ex2() {
    assert_eq!(sos(50),1);
}

#[test]
fn test_ex3() {
    assert_eq!(sos(52),0);
}

fn sos (n: u32) -> u8 {
    let mut t=0;
    for i in n.to_string().chars() {
        let ii=i.to_digit(10).unwrap();
        t+=ii*ii;
    }
    let s=(t as f64).sqrt() as u32;
    if s*s == t {
        return 1;
    } else {
        return 0;
    }
}
