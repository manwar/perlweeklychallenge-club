#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(arrangebinary(vec![1, 0, 0, 0, 1], 1), true);
}

#[test]
fn test_ex2() {
    assert_eq!(arrangebinary(vec![1, 0, 0, 0, 1], 2), false);
}

fn arrangebinary(a: Vec<u8>, n: u8) -> bool {
    let mut b = a.clone();
    let mut t = n;
    for i in 0..b.len() {
        if b[i] == 0
            && (i == 0 || b[i - 1] == 0)
            && (i == b.len() - 1 || b[i + 1] == 0)
        {
            b[i] = 1;
            t -= 1;
            if t == 0 {
                break;
            }
        }
    }
    t == 0
}
