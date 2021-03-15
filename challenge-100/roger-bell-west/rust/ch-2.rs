#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(ts(vec![vec![1],vec![2,4],vec![6,4,9],vec![5,1,7,2]]),8);
}

#[test]
fn test_ex2() {
    assert_eq!(ts(vec![vec![3],vec![3,1],vec![5,2,3],vec![4,3,1,3]]),7);
}

pub struct Node {
    n: usize,
    i: usize,
    s: i32
}

fn ts(inp: Vec<Vec<i32>>) -> i32 {
    let mut b: Vec<Node>=vec![];
    let mut n: usize=0;
    let mut i: usize=0;
    let mut s: i32=inp[0][0];
    let mut r: Vec<i32>=vec![];
    loop {
        if b.len() > 0 {
            let t=b.pop().unwrap();
            n=t.n;
            i=t.i;
            s=t.s;
        }
        if n < inp.len()-1 {
            n += 1;
            for ix in i..i+2 {
                b.push(Node {n: n,
                             i: ix,
                             s: s+inp[n][ix]
                });
            }
        } else {
            r.push(s);
        }
        if b.len()==0 {
            break;
        }
    }
    return *r.iter().min().unwrap();
}
