#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(bp(4),vec![
  vec![1,1,1,1],
  vec![1,1,2],
  vec![1,2,1],
  vec![1,3],
  vec![2,1,1],
  vec![2,2],
  vec![3,1],
    ]);
}

#[test]
fn test_ex2() {
    assert_eq!(bp(5),vec![
  vec![1,1,1,1,1],
  vec![1,1,1,2],
  vec![1,1,2,1],
  vec![1,1,3],
  vec![1,2,1,1],
  vec![1,2,2],
  vec![1,3,1],
  vec![2,1,1,1],
  vec![2,1,2],
  vec![2,2,1],
  vec![2,3],
  vec![3,1,1],
  vec![3,2],
  ]);
}

fn bp (n: u32) -> Vec<Vec<u32>> {
    let mut o=vec![];
    let mut p=vec![vec![]];
    while p.len() > 0 {
        let s=p.pop().unwrap();
        let t: u32=s.iter().sum();
        if t==n {
            o.push(s);
        } else {
            let mut mx=n-t;
            if mx > 3 {
                mx=3;
            }
            for i in 1..=mx {
                let mut q=s.clone();
                q.push(i);
                p.push(q);
            }
        }
    }
    o.reverse();
    return o;
}
