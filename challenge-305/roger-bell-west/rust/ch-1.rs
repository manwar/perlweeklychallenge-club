#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(binaryprefix(vec![1, 0, 1]), vec![false, true, true]);
}

#[test]
fn test_ex2() {
    assert_eq!(binaryprefix(vec![1, 1, 0]), vec![false, true, false]);
}

#[test]
fn test_ex3() {
    assert_eq!(binaryprefix(vec![1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]), vec![false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true]);
}

fn isqrt(s: u32) -> u32 {
    if s <= 1 {
        return s;
    }
    let mut x0 = s / 2;
    let mut x1 = (x0 + s / x0) / 2;
    while x1 < x0 {
        x0 = x1;
        x1 = (x0 + s / x0) / 2;
    }           
    return x0;
}

fn is_prime(n: u32) -> bool {
    if n == 1 {
        return false;
    }
    if n>2 && n%2==0 {
        return false;
    }
    if n>3 && n%3==0 {
        return false;
    }
    let lim = isqrt(n);
    let mut k6 = 0;
    loop {
        k6 += 6;
        for t in [k6 - 1,k6 + 1] {
            if t <= lim {
                if n % t == 0 {
                    return false;
                }
            } else {
                return true;
            }
        }
    }
}

fn binaryprefix(a: Vec<u8>) -> Vec<bool> {
    let mut out = Vec::new();
    let mut n = 0;
    for x in a {
        n *= 2;
        if x == 1 {
            n += 1;
        }
        out.push(is_prime(n));
    }
    out
}

