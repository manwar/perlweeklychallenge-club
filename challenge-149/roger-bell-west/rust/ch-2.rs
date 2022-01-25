#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::convert::TryInto;

#[test]
fn test_ex1() {
    assert_eq!(ls(2),"1");
}

#[test]
fn test_ex2() {
    assert_eq!(ls(4),"3201");
}

#[test]
fn test_ex3() {
    assert_eq!(ls(10),"9814072356");
}

#[test]
fn test_ex4() {
    assert_eq!(ls(12),"B8750A649321");
}

fn ls(base: u64) -> String {
    let mut max=0u64;
    for i in (0..base).rev() {
        max *= base;
        max += i;
    }
    let mut t=(max as f64).sqrt() as u64;
    loop {
        let mut s=t*t;
        let mut v=true;
        let mut c=vec![0u64;base.try_into().unwrap()];
        let mut dg: Vec<char>=Vec::new();
        while s > 0 {
            let d = (s % base) as usize;
            c[d] += 1;
            if c[d] > 1 {
                v=false;
                break;
            }
            s /= base;
            dg.push(std::char::from_digit(d.try_into().unwrap(),
                                          base.try_into().unwrap()).unwrap());
        }
        if v {
            return dg.iter().rev().collect::<String>().to_uppercase();
        }
        t -= 1;
    }
}
