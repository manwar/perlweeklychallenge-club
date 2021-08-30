#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(msm(vec![vec![1,0,0,0,1,0],vec![1,1,0,0,0,1],vec![1,0,0,0,0,0]]),
               vec![vec![0,0,0],vec![0,0,0]]);
}

#[test]
fn test_ex2() {
    assert_eq!(msm(vec![vec![0,0,1,1],vec![0,0,0,1],vec![0,0,1,0]]),
               vec![vec![0,0],vec![0,0],vec![0,0]]);
}

fn msm(m: Vec<Vec<i64>>) -> Vec<Vec<i64>> {
    let y=m.len();
    let x=m[0].len();
    let mut mxa: usize=0;
    let mut oc: Vec<usize>=vec![];
    for yi in 0..y {
        for xi in 0..x {
            if m[yi][xi]==0 {
                let mut rl: Vec<usize>=vec![];
                let mut mrl=x-xi;
                for yj in yi..y {
                    for xj in xi..min(xi+mrl,x) {
                        if m[yj][xj] != 0 {
                            mrl=min(xj-xi,mrl);
                            break;
                        }
                    }
                    rl.push(mrl);
                }
                for n in 0..rl.len() {
                    if rl[n]>0 {
                        let a=rl[n]*(n+1);
                        if a >= mxa {
                            mxa=a;
                            oc=vec![rl[n],n+1];
                        }
                    }
                }
            }
        }
    }
    return vec![vec![0;oc[0]];oc[1]];
}

fn min(a: usize,b: usize) -> usize {
    if a < b {
        return a;
    }
    return b;
}
