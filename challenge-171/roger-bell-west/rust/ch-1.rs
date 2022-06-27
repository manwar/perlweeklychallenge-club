#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        oddabundant(20),
        vec!(
            945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985, 6435,
            6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505, 8925
        )
    );
}

fn abundant(n: usize) -> bool {
    if n == 1 {
        return false;
    }
    let mut ff = 1;
    let mut s = (n as f64).sqrt() as usize;
    if s * s == n {
        ff += s;
        s -= 1;
    }
    for pf in 2..=s {
        if n % pf == 0 {
            ff += pf + n / pf;
            if ff > n {
                return true;
            }
        }
    }
    false
}

fn oddabundant(ct: usize) -> Vec<usize> {
    let mut n = 1;
    let mut o = Vec::new();
    loop {
        if abundant(n) {
            o.push(n);
            if o.len() >= ct {
                break;
            }
        }
        n += 2;
    }
    return o;
}
