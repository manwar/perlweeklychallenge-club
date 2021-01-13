#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(mp(vec![vec![1,1],vec![2,2],vec![3,3]]),3);
}

#[test]
fn test_ex2() {
    assert_eq!(mp(vec![vec![1,1],vec![2,2],vec![3,1],vec![1,3],vec![5,3]]),3);
}

fn mp(cx: Vec<Vec<i32>>) -> i32 {
    let epsilon=0.0001;
    let mut mxp: i32 = 0;
    for a in 0..=cx.len()-3 {
        for b in a+1..=cx.len()-2 {
            let d: Vec<i32>=(0..=1).map(|i| cx[b][i]-cx[a][i]).collect();
            let mut pil: i32=2;
            for c in b+1..=cx.len()-1 {
                let mut tp=false;
                let v: Vec<i32>=(0..=1).map(|i| cx[c][i]-cx[a][i]).collect();
                if d[0]==0 {
                    if v[0]==0 {
                        tp=true;
                    }
                } else if d[1]==0 {
                    if v[1]==0 {
                        tp=true;
                    }
                } else if ((v[0] as f64)/(d[0] as f64)-(v[1] as f64)/(d[1] as f64)).abs() < epsilon {
                    tp=true;
                }
                if tp {
                    pil += 1;
                }
            }
            if pil > mxp {
                mxp = pil;
            }
        }
    }
    return mxp;
}
