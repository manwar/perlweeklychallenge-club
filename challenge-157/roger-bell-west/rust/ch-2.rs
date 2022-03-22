#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(brazilian(7), true);
}

#[test]
fn test_ex2() {
    assert_eq!(brazilian(6), false);
}

#[test]
fn test_ex3() {
    assert_eq!(brazilian(8), true);
}

fn brazilian(n: u64) -> bool {
    for b in 2..n - 1 {
        let mut nn = n;
        let mut braz = true;
        let digit = nn % b;
        while nn > 0 {
            if digit == nn % b {
                nn /= b;
            } else {
                braz = false;
                break;
            }
        }
        if braz {
            return true;
        }
    }
    false
}
