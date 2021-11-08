#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::cmp::{min,max};

#[test]
fn test_ex1() {
    assert_eq!(bst(vec![
        8,
        5,      9,
        4,  6,  0,  0
    ]),1);
}

#[test]
fn test_ex2() {
    assert_eq!(bst(vec![
        5,
        4,      7,
        3,  6,  0,  4
    ]),0);
}

fn bst(tree: Vec<u64>) -> i8 {
    let mut limit: Vec<(u64,u64)>=vec![];
    for i in &tree {
        limit.push((*i,*i));
    }
    for s in (0..=((tree.len()-1)/2)-1).rev() {
        let child=s*2+1;
        for sb in 0..=1 {
            let ac=child+sb;
            if sb==0 && tree[s]!=0 && limit[ac].1 > tree[s] {
                return 0;
            }
            if sb==1 && limit[ac].0!=0 && limit[ac].0 < tree[s] {
                return 0;
            }
        }
        limit[s]=(tree[s],max(tree[s],limit[child+1].1));
        if limit[child].0 > 0 {
            limit[s].0=min(tree[s],limit[child].0);
        }
    }
    return 1;
}
