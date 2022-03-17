#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(pernicious(10), vec![3, 5, 6, 7, 9, 10, 11, 12, 13, 14]);
}

fn isprime(candidate: u32) -> bool {
    if candidate < 2 {
        return false;
    } else if candidate == 2 {
        return true;
    } else if candidate == 3 {
        return true;
    } else if candidate % 2 == 0 {
        return false;
    } else if candidate % 3 == 0 {
        return false;
    }
    let mut anchor = 0u32;
    let limit = (candidate as f64).sqrt() as u32;
    loop {
        anchor += 6;
        for t in [anchor - 1, anchor + 1].iter() {
            if *t > limit {
                return true;
            }
            if candidate % *t == 0 {
                return false;
            }
        }
    }
}

fn pernicious(n: usize) -> Vec<usize> {
    let mut out: Vec<usize> = Vec::new();
    let mut c: usize = 1;
    loop {
        if isprime(c.count_ones()) {
            out.push(c);
            if out.len() >= n {
                break;
            }
        }
        c += 1;
    }
    out
}
