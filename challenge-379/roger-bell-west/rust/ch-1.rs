#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(reversestring(""), "");
}

#[test]
fn test_ex2() {
    assert_eq!(reversestring("reverse the given string"), "gnirts nevig eht esrever");
}

fn reversestring(a: &str) -> String {
    let mut b = String::new();
    if a == "" {
        return b;
    }
    let l = a.len() - 1;
    let aa = a.chars().collect::<Vec<_>>();
    for i in 0 ..= l {
        b.push(aa[l - i]);
    }
    b
}
