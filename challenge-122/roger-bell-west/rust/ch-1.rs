#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(aos(vec![10, 20, 30, 40, 50, 60, 70, 80, 90]),vec![10, 15, 20, 25, 30, 35, 40, 45, 50]);
}

fn aos (m: Vec<i64>) -> Vec<i64> {
    let mut n=0;
    let mut t=0;
    let mut o=vec![];
    for i in m {
        t+=i;
        n+=1;
        o.push(t/n)
    }
    return o;
}
