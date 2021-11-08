#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(bp(5),1);
}

#[test]
fn test_ex2() {
    assert_eq!(bp(4),0);
}

fn bp (n: u64) -> u64 {
    let s: Vec<char>=format!("{:b}",n).chars().collect();
    let l=s.len()-1;
    for i in 0..=l/2 {
        if s[i] != s[l-i] {
            return 0;
        }
    }
    return 1;
}
