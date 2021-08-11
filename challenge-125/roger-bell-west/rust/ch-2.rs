#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(btd(vec![1,
                        2,5,
                        3,4,6,7,
                        0,0,0,0,0,0,8,10,
                        0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0
    ]),6);
}

fn btd(tree: Vec<u64>) -> u64 {
    let st=tree.len();
    let mut depth: Vec<u64>=vec![0;st];
    let mut diameter: Vec<u64>=vec![0;st];
    for i in (0..st).rev() {
        if tree[i]!=0 {
            let a=i*2+1;
            let b=a+1;
            if b < st {
                depth[i]=1+[depth[a],depth[b]].iter().max().unwrap();
                diameter[i]=*[
                    depth[a]+depth[b],
                    diameter[a],
                    diameter[b]
                    ].iter().max().unwrap();
            } else {
                depth[i]=1;
            }
        }
    }
    return diameter[0]
}
