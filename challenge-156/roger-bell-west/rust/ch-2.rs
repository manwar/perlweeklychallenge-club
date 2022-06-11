#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(is_weird(12), false);
}

#[test]
fn test_ex2() {
    assert_eq!(is_weird(13), false);
}

#[test]
fn test_ex3() {
    assert_eq!(is_weird(70), true);
}

fn divisors(n: usize) -> Vec<usize> {
    let mut ff = Vec::from([1]);
    if n == 1 {
        return ff;
    }
    let mut s = (n as f64).sqrt() as usize;
    if s * s == n {
        ff.push(s);
        s -= 1;
    }
    for pf in 2..=s {
        if n % pf == 0 {
            ff.push(pf);
            ff.push(n / pf);
        }
    }
    ff
}

fn is_weird(n: usize) -> bool {
    let dd = divisors(n);
    if dd.iter().sum::<usize>() <= n {
        return false;
    }
    for mask in 1..(1 << dd.len()) {
        let mut ss = 0;
        for (i, d) in dd.iter().enumerate() {
            if (mask & 1 << i) > 0 {
                ss += *d;
                if ss > n {
                    break;
                }
            }
            if ss == n {
                return false;
            }
        }
    }
    return true;
}
