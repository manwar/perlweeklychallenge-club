#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sedolv("2936921"),1);
}

#[test]
fn test_ex2() {
    assert_eq!(sedolv("1234567"),0);
}

#[test]
fn test_ex3() {
    assert_eq!(sedolv("B0YBKL9"),1);
}

#[test]
fn test_ex4() {
    assert_eq!(sedolv("A0ZBKL9"),0);
}

#[test]
fn test_ex5() {
    assert_eq!(sedolv("B2YBIL9"),0);
}

fn sedolv(sedol: &str) -> u8 {
    if sedol.len() != 7 {
        return 0;
    }
    let w=vec![1,3,1,7,3,9,1].into_iter();
    let mut s=0;
    let j=w.zip(sedol.chars().into_iter());
    for x in j {
        let n;
        if x.1.is_digit(10) ||
            (x.1.is_ascii_alphabetic() && x.1.is_ascii_uppercase() &&
             x.1 != 'A' && x.1 != 'E' && x.1 != 'I' && 
             x.1 != 'O' && x.1 != 'U') {
            n=x.1.to_digit(36).unwrap();
        } else {
            return 0;
        }
        s += n*x.0;
    }
    if s % 10 == 0 {
        return 1;
    }
    0
}
