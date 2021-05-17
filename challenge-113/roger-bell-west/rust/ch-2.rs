#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(rbt(vec![1,2,3,4,-1,5,6,-1,7]),vec![27,26,25,24,-1,23,22,-1,21]);
}

fn rbt (ti: Vec<i64>) -> Vec<i64> {
    let mut s: i64=0;
    for n in &ti {
        if *n>0 {
            s += n;
        }
    }
    let mut to=vec![];
    for n in ti {
        if n>0 {
            to.push(s-n);
        } else {
            to.push(n);
        }
    }
    return to;
}
