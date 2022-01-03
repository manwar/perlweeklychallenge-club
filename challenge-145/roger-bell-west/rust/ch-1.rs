#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        dotproduct(vec![1,2,3],vec![4,5,6]),32);
}

fn dotproduct(a: Vec<u32>, b: Vec<u32>) -> u32 {
    let mut p=0;
    for (i,va) in a.iter().enumerate() {
        p+=va*b[i];
    }
    p
}
