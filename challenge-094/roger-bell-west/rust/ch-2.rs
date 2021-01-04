#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(bt2ll(vec![1,2,3,4,5,-1,-1,-1,-1,6,7]),vec![1,2,4,5,6,7,3]);
}

fn bt2ll(tree: Vec<i32>) -> Vec<i32> {
    return recurse(tree,0);
}

fn recurse(tree: Vec<i32>, start: usize) -> Vec<i32> {
    let mut out=vec![tree[start]];
    let b=start*2+1;
    for ba in b..=b+1 {
        if ba < tree.len() && tree[ba]>-1 {
            for t in recurse(tree.clone(),ba) {
                out.push(t);
            }
        }        
    }
    return out;
}

