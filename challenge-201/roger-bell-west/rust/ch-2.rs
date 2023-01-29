#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(pennypiles(5), 7);
}

#[test]
fn test_ex2() {
    assert_eq!(pennypiles(10), 42);
}

fn pennypiles(n: isize) -> isize {
    if n == 0 {
        return 1;
    }
    let mut s = 0;
    let mut j = n - 1;
    let mut k = 2;
    while j >= 0 {
        let t = pennypiles(j);
        if (k / 2) % 2 == 1 {
            s += t;
        } else {
            s -= t;
        }
        if k % 2 == 1 {
            j -= k;
        } else {
            j -= k / 2;
        }
        k += 1;
    }
    s
}
