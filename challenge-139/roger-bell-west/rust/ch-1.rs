#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(jortsort(vec![1,2,3,4,5]),true);
}

#[test]
fn test_ex2() {
    assert_eq!(jortsort(vec![1,3,2,4,5]),false);
}

fn jortsort(a: Vec<i32>) -> bool {
    for i in a.windows(2) {
        if i[0] > i[1] {
            return false;
        }
    }
    true
}
