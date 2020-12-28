#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sp(vec![1,2,-1,3,4]),13);
}

#[test]
fn test_ex2() {
    assert_eq!(sp(vec![1,2,3,4,-1,5,6]),26);
}

use std::collections::VecDeque;

fn sp(t: Vec<i32>) -> i32 {
    let mut s: i32=0;
    let mut path: VecDeque<Vec<i32>>=VecDeque::new();
    path.push_back(vec![0]);
    while path.len() > 0 {
        let a=path.pop_front().unwrap();
        let c=((a.last().unwrap()+1)*2-1) as usize;
        let mut tn=true;
        for ac in c..=c+1 {
            if ac < t.len() && t[ac]>-1 {
                let mut b=a.clone();
                b.push(ac as i32);
                path.push_back(b);
                tn=false;
            }
        }
        if tn {
            s+=a.iter().map(|i| t[*i as usize]).sum::<i32>();
        }
    }
    return s;
}
