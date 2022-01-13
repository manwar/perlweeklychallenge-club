#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(longprime(5),vec![7, 17, 19, 23, 29]);
}

#[test]
fn test_ex2() {
    assert_eq!(longprime(60),vec![7, 17, 19, 23, 29, 47, 59, 61, 97, 109, 113, 131, 149, 167, 179, 181, 193, 223, 229, 233, 257, 263, 269, 313, 337, 367, 379, 383, 389, 419, 433, 461, 487, 491, 499, 503, 509, 541, 571, 577, 593, 619, 647, 659, 701, 709, 727, 743, 811, 821, 823, 857, 863, 887, 937, 941, 953, 971, 977, 983]);
}

fn is_prime(n: u32) -> bool {
    if n>2 && n%2==0 {
        return false;
    }
    if n>3 && n%3==0 {
        return false;
    }
    let lim=(n as f64).sqrt() as u32;
    let mut k6=0;
    loop {
        k6+=6;
        for t in [k6-1,k6+1] {
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

fn longprime(n: u32) -> Vec<u32> {
    let mut nn=n;
    let mut o=vec![];
    let mut ba=vec![7];
    let mut k6=6;
    while nn>0 {
        if ba.len()==0 {
            k6+=6;
            ba=vec![k6+1,k6-1];
        }
        let b=ba.pop().unwrap();
        if is_prime(b) {
            let mut k=1;
            let mut l=0;
            loop {
                k *= 10;
                l += 1;
                k %= b;
                if k==1 {
                    break;
                }
            }
            if l==b-1 {
                o.push(b);
                nn-=1;
            }
        }
    }
    o
}
