#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(threepower(27), true);
}

#[test]
fn test_ex2() {
    assert_eq!(threepower(0), false);
}

#[test]
fn test_ex3() {
    assert_eq!(threepower(6), false);
}

fn threepower(n0: i32) -> bool {
    if n0 == 0 {
        return false;
    }
    let n = n0.abs();
    let mut lo = 1;
    let mut hi = n / 2;
    loop {
        let t = (lo + hi) / 2;
        let c = t * t * t;
        if c == n {
            return true;
        }
        if lo == t {
            return false;
        }
        if c < n {
            lo = t;
        } else {
            hi = t;
        }
    }
}
