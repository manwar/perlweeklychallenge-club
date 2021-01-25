#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(bs("101100101",3),1);
}

#[test]
fn test_ex2() {
    assert_eq!(bs("00011011",2),4);
}

fn diff(a: &str,b: &str) -> i64 {
    let mut d: i64=0;
    for (s,t) in a.chars().zip(b.chars()) {
        if s != t {
            d+=1;
        }
    }
    return d;
}

fn bs(b: &str, s: i64) -> i64 {
    let mut bb: Vec<String>=vec![];
    let mut i=0;
    while i<b.len() {
        bb.push(b[i..i+(s as usize)].to_string());
        i+=s as usize;
    }
    if bb[bb.len()-1].len() != s as usize {
        return -1;
    }
    let mut mc: i64 = -1;
    let mut cost=vec![vec![0; bb.len()]; bb.len()];
    for x in 0..bb.len()-1 {
        cost[x][x]=0;
        for y in x+1..bb.len() {
            let t=diff(&bb[x],&bb[y]);
            cost[x][y]=t;
            cost[y][x]=t;
        }
        let tc=(0..bb.len()).map(|i| cost[x][i]).sum();
        if mc==-1 || tc < mc {
            mc=tc;
        }
    }
    return mc;
}
