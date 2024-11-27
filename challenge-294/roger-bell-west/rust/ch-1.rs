#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(consecutivesequence(vec![10, 4, 20, 1, 3, 2]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(consecutivesequence(vec![0, 6, 1, 8, 5, 2, 4, 3, 0, 7]), 9);
}

#[test]
fn test_ex3() {
    assert_eq!(consecutivesequence(vec![10, 30, 20]), -1);
}

fn consecutivesequence(a: Vec<u32>) -> isize {
    let mut b = a.clone();
    b.sort();
    let mut mxlen: isize = 0;
    let mut here = 0;
    loop {
        for there in here + 1 .. b.len() {
            if b[there] != (there - here) as u32 + b[here] {
                let l = there - here;
                if l as isize > mxlen {
                    mxlen = l as isize;
                }
                here = there;
                break;
            }
            if there == b.len() - 1 {
                let l = there - here + 1;
                if l as isize > mxlen {
                    mxlen = l as isize;
                }
                here = there;
                break;
            }
        }
        if here >= b.len() - 1 {
            break;
        }
    }
    if mxlen < 2 {
        mxlen = -1;
    }
    mxlen
}
