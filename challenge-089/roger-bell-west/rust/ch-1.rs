#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(gs(3),3);
}

#[test]
fn test_ex2() {
    assert_eq!(gs(4),7);
}

fn gs(n: i32) -> i32 {
    let mut tot=n-1;
    for a in 2..n {
        for x in a+1..n+1 {
            tot+=gcd(a,x);
        }
    }
    return tot;
}

fn gcd(mut a: i32,mut b: i32) -> i32 {
    if a==0 {
        return b;
    }
    if b==0 {
        return a;
    }
    let mut d=0;
    loop {
        if a == b {
            return a << d;
        }
        let aa=a % 2 == 0;
        let bb=b % 2 == 0;
        if aa && bb {
            a >>= 1;
            b >>= 1;
            d+=1;
        } else if aa {
            a >>= 1;
        } else if bb {
            b >>= 1;
        } else {
            let c=(a-b).abs();
            a=min(a,b);
            b=c >> 1;
        }
    }
}

fn min<T: Ord>(value1: T, value2: T) -> T {
    if value1 <= value2 {
        value1
    } else {
        value2
    }
}
