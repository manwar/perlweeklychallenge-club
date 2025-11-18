#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(converttime("02:30", "02:45"), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(converttime("11:55", "12:15"), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(converttime("09:00", "13:00"), 4);
}

#[test]
fn test_ex4() {
    assert_eq!(converttime("23:45", "00:30"), 3);
}

#[test]
fn test_ex5() {
    assert_eq!(converttime("14:20", "15:25"), 2);
}

fn hm2m(a: &str) -> u32 {
    let p = a.split(':').map(|x| x.parse::<u32>().unwrap()).collect::<Vec<_>>();
    p[0] * 60 + p[1]
}

fn converttime(ssrc: &str, ttgt: &str) -> u32 {
    let src = hm2m(ssrc);
    let mut tgt = hm2m(ttgt);
    if tgt < src {
        tgt += 24 * 60;
    }
    let mut delta = tgt - src;
    let mut oc = 0;
    for op in [60, 15, 5, 1] {
        oc += delta / op;
        delta %= op;
    }
    oc
}
