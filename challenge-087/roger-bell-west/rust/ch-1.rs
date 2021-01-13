#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(lcs(vec![100, 4, 50, 3, 2]),vec![2,3,4]);
}

#[test]
fn test_ex2() {
    assert_eq!(lcs(vec![20, 30, 10, 40, 50],),vec![0]);
}

#[test]
fn test_ex3() {
    assert_eq!(lcs(vec![20, 19, 9, 11, 10],),vec![9,10,11]);
}

#[test]
fn test_ex4() {
    assert_eq!(lcs(vec![20, 19, 18, 11, 10],),vec![18,19,20]);
}

fn lcs(ns: Vec<i32>) -> Vec<i32> {
    let mut l=ns;
    l.sort();
    l.reverse();
    let mut w=Vec::<i32>::with_capacity(l.len());
    let mut r=vec![0];
    while l.len()>0 {
            let nn=l.pop();
            let n: i32;
            match nn {
                None => break,
                Some(x) => n = x,
            }
            if w.len()==0 || n == w[w.len()-1]+1 {
                        w.push(n);
                    } else {
                        if w.len() > r.len() {
                                r = w;
                            }
                           w=Vec::<i32>::with_capacity(l.len());
                           w.push(n);
                    }
        }
          if w.len() > r.len() {
                  r = w;
              }
             return r;
}
