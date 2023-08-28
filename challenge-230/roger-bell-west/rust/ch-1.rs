#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(separatedigits(vec![1, 34, 5, 6]), vec![1, 3, 4, 5, 6]);
}

#[test]
fn test_ex2() {
    assert_eq!(separatedigits(vec![1, 24, 51, 60]), vec![1, 2, 4, 5, 1, 6, 0]);
}

fn separatedigits(a: Vec<u32>) -> Vec<u32> {
    let mut out = Vec::new();
    for n in a {
        let mut m = n;
        let mut v = Vec::new();
        while m > 0 {
            v.push(m % 10);
            m /= 10;
        }
        v.reverse();
        out.append(&mut v);
    }
    out
}
