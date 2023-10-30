#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(removeone(vec![0, 2, 9, 4, 6]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(removeone(vec![5, 1, 3, 2]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(removeone(vec![2, 2, 3]), true);
}

fn removeone(a: Vec<i64>) -> bool {
    let mut ec = 0u32;
    let mut le = 1 + a[1] - a[0];
    for s in a.windows(2) {
        if s[1] <= s[0] {
            ec += 1;
            if ec > 1 || s[0] - s[1] >= le {
                return false;
            }
        }
        le = s[1] - s[0];
    }
    true
}
