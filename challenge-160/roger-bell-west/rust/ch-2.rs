#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        equilibriumindex(vec![1,3,5,7,9]),
        3
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        equilibriumindex(vec![1,2,3,4,5]),
        -1
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        equilibriumindex(vec![2,4,2]),
        1
    );
}

fn equilibriumindex(s: Vec<isize>) -> isize {
    let sm=&s.iter().sum::<isize>();
    let mut sa=0;
    for (i,v) in s.iter().enumerate() {
        sa += v;
        if sa == *sm {
            return i as isize;
        }
        sa += v;
    }
    -1
}
