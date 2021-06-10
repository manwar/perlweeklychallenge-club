#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(mg(vec![2,9,3,5]),4);
}

#[test]
fn test_ex2() {
    assert_eq!(mg(vec![1,3,8,2,0]),5);
}

#[test]
fn test_ex3() {
    assert_eq!(mg(vec![5]),0);
}

fn mg(aa: Vec<i64>) -> i64 {
    let mut a=aa;
    a.sort();
    let mut g=0;
    for i in 0..a.len()-1 {
        let d=(a[i]-a[i+1]).abs();
        if d>g {
            g=d;
        }
    }
    return g;
}
