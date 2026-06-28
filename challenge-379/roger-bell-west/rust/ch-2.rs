#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(armstrongnumber(10, 1000), vec![0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407]);
}

#[test]
fn test_ex2() {
    assert_eq!(armstrongnumber(7, 1000), vec![0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250]);
}

#[test]
fn test_ex3() {
    assert_eq!(armstrongnumber(16, 1000), vec![0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645]);
}

fn pow(x0: u32, pow0: u32) -> u32 {
    let mut x = x0;
    let mut pow = pow0;
    let mut ret = 1;
    while pow > 0 {
        if (pow & 1) == 1 {
            ret *= x;
        }
        x *= x;
        pow >>= 1;
    }
    ret
}

fn armstrongnumber(base: u32, limit: u32) -> Vec<u32> {
    let mut out = Vec::new();
    for candidate in 0 .. limit {
        let mut digits = Vec::new();
        if candidate == 0 {
            digits.push(0);
        } else {
            let mut c = candidate;
            while c > 0 {
                digits.push(c % base);
                c /= base;
            }
        }
        let dl = digits.len() as u32;
        let test = digits.iter().map(|x| pow(*x, dl)).sum::<u32>();
        if test == candidate {
            out.push(candidate);
        }
    }
    out
}
