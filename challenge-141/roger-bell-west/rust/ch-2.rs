#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(likenumber(1234,2),9);
}

#[test]
fn test_ex2() {
    assert_eq!(likenumber(768,4),3);
}

fn likenumber(source: u32,factor: u32) -> u32 {
    let s: Vec<u32>=source.to_string().chars().map(|i| i.to_digit(10).unwrap()).collect();
    let m=s.len();
    let mut n=0;
    for mask in 1..((1<<m)-1) {
        let mut c=0;
        for di in 0..m {
            if (mask & 1<<di) > 0 {
                c=c*10+s[di];
            }
        }
        if c % factor == 0 {
            n+=1;
        }
    }
    n
}
