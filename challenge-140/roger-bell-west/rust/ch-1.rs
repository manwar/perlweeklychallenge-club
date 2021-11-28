#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(dcbadd(11,1),100);
}

#[test]
fn test_ex2() {
    assert_eq!(dcbadd(101,1),110);
}

#[test]
fn test_ex3() {
    assert_eq!(dcbadd(100,11),111);

}

fn cvradix(n: u32,r: u32,tf: u32) -> u32 {
    let mut o=0;
    let mut nn=n;
    let mut m=1;
    let ra;
    let rb;
    if tf==0 {
        ra=r;
        rb=10;
    } else {
        ra=10;
        rb=r;
    }
    while nn>0 {
        o+=(nn % ra) * m;
        nn /= ra;
        m *= rb;
    }
    return o;
}

fn dcbadd(a: u32,b:u32) -> u32 {
    return cvradix(cvradix(a,2,1)+cvradix(b,2,1),2,0);
}
