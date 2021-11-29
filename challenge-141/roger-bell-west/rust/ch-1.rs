#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(divisors(8,10),vec![24,30,40,42,54,56,66,70,78,88]);
}

fn factorcount(n: u32) -> u32 {
    if n==1 {
        return 1;
    }
    let mut f=2;
    let mut s=(n as f64).sqrt() as u32;
    if s*s==n {
        s-=1;
        f+=1;
    }
    for pf in 2..=s {
        if n % pf == 0 {
            f+=2;
        }
    }
    f
}

fn divisors(count: u32,n: u32) -> Vec<u32> {
    let mut nn=n;
    let mut a=vec![];
    let mut t=0;
    while nn>0 {
        t+=1;
        if factorcount(t)==count {
            a.push(t);
            nn-=1
        }
    }
    a
}
