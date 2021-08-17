#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(cn(15),8);
}

#[test]
fn test_ex2() {
    assert_eq!(cn(25),13);
}

#[test]
fn test_ex3() {
    assert_eq!(cn(10000),6560);
}

#[test]
fn test_ex4() {
    assert_eq!(cn(100000000),43046720);
}

fn cn(n: i64) -> i64 {
    let mut k=n;
    let mut digits: Vec<i64>=vec![];
    while k>0 {
        let mut d=k % 10;
        if d==1 {
            digits=vec![8;digits.len()];
        }
        if d>0 {
            d -= 1;
        }
        digits.push(d);
        k /= 10;
    }
    let mut tc: i64=0;
    for i in (0..=digits.len()-1).rev() {
        tc *= 9;
        tc += digits[i];
    }
    return tc;
}
