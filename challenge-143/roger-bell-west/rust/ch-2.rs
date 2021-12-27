#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(is_stealthy(36), true);
}

#[test]
fn test_ex2() {
    assert_eq!(is_stealthy(12), true);
}

#[test]
fn test_ex3() {
    assert_eq!(is_stealthy(6), false);
}

fn factorpairs(n: i32) -> Vec<i32> {
    let mut ff = vec![];
    if n == 1 {
        ff.push(2);
        return ff;
    }
    let mut s = (n as f64).sqrt() as i32;
    if s * s == n {
        ff.push(s * 2);
        s -= 1;
    }
    for pf in 2..=s {
        if n % pf == 0 {
            ff.push(pf + n / pf);
        }
    }
    ff.push(1 + n);
    ff
}

fn is_stealthy(n: i32) -> bool {
    let p = factorpairs(n);
    if p.len() == 1 {
        return false;
    }
    for ix in 0..p.len() - 1 {
        for iy in ix + 1..p.len() {
            if (p[ix] - p[iy]).abs() == 1 {
                return true;
            }
        }
    }
    false
}
