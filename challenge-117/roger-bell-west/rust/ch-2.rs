#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashSet;
use std::iter::FromIterator;

#[test]
fn test_ex1() {
    assert_eq!(fpp(2),vec!["LHLH","LHR","LLHH","LRH","RLH","RR"]);
}

#[test]
fn test_ex2() {
    assert_eq!(fpp(1),vec!["LH","R"]);
}

fn fpp(n: i32) -> Vec<String> {
    let mut o: HashSet<String>=HashSet::new();
    let mut chain=vec![("".to_string(),0,0)];
    let mut lim=(n-1)*4;
    if n==1 {
        lim=2;
    }
    while chain.len()>0 {
        let p=chain.pop().unwrap();
        let x=p.1;
        let y=p.2;
        if y >= lim {
            o.insert(p.0);
        } else {
            let mut mxx=y+1;
            if y >= n {
                mxx=lim-y-1;
            }
            for txi in 0..=2 {
                let tx=x-1+txi;
                if tx>=0 && tx<=mxx {
                    let mut ss=p.0.clone();
                    if txi==0 {
                        ss.push('H');
                        chain.push((ss,x-1,y+1));
                    } else if txi==1 {
                        ss.push('R');
                        chain.push((ss,x,y+2));
                    } else {
                        ss.push('L');
                        chain.push((ss,x+1,y+1));
                    }
                }
            }
        }
    }
    let mut y=Vec::from_iter(o);
    y.sort();
    return y;
}
