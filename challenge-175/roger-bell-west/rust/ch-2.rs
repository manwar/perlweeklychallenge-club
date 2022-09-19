#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        perfecttotient(20),
        vec![
            3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729, 2187,
            2199, 3063, 4359, 4375, 5571
        ]
    );
}

fn gcd(m0: usize, n0: usize) -> usize {
    let mut m = m0;
    let mut n = n0;
    while n != 0 {
        let t = n;
        n = m % n;
        m = t;
    }
    m
}

fn eulertotient(n: usize) -> usize {
    let mut et = 0;
    for k in 1..n {
        if gcd(n, k) == 1 {
            et += 1;
        }
    }
    et
}

fn iteratedtotient(n0: usize) -> usize {
    let mut p = 0;
    let mut n = n0;
    loop {
        n = eulertotient(n);
        p += n;
        if n == 1 {
            break;
        }
        if p > n0 {
            break;
        }
    }
    p
}

fn perfecttotient(ct: usize) -> Vec<usize> {
    let mut o = Vec::new();
    let mut n = 1;
    while o.len() < ct {
        n += 1;
        if iteratedtotient(n) == n {
            o.push(n);
        }
    }
    o
}
