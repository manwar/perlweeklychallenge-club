#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(nroot(5.0,248832.0),12.0);
}

#[test]
fn test_ex2() {
    assert_eq!(nroot(5.0,34.0),(34.0 as f64).powf(0.2));
}

fn nroot(n: f64,a: f64) -> f64 {
    let mut xk: f64=2.0;
    loop {
        let xk1=((n-1.0)*xk+a/(xk.powf(n-1.0)))/n;
        if xk1==xk {
            break;
        }
        xk=xk1;
    }
    return xk;
}
