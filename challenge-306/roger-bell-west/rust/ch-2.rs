#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(lastelement(vec![3, 8, 5, 2, 9, 2]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(lastelement(vec![3, 2, 5]), 0);
}

fn lastelement(a: Vec<u32>) -> u32 {
    let mut b = a.clone();
    loop {
        b.sort();
        let f = b.pop().unwrap();
        let s = b.pop().unwrap();
        if f > s {
            b.push(f - s);
        }
        if b.len() == 0 {
            return 0;
        }
        if b.len() == 1 {
            return b[0];
        }
    }
}
