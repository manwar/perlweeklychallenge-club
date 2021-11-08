#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(csa(vec![1,2,3,6,7,8,9]),vec![vec![1,2,3],vec![6,7,8,9]]);
}

#[test]
fn test_ex2() {
    assert_eq!(csa(vec![11,12,14,17,18,19]),vec![vec![11,12],vec![14],vec![17,18,19]]);
}

#[test]
fn test_ex3() {
    assert_eq!(csa(vec![2,4,6,8]),vec![vec![2],vec![4],vec![6],vec![8]]);
}

#[test]
fn test_ex4() {
    assert_eq!(csa(vec![1,2,3,4,5]),vec![vec![1,2,3,4,5]]);
}

fn csa(list: Vec<u64>) -> Vec<Vec<u64>> {
    let mut o=vec![vec![list[0]]];
    let mut i=list.iter();
    i.next();
    for n in i {
        if o.last().unwrap().last().unwrap()+1 != *n {
            o.push(vec![]);
        }
        let i=o.len()-1;
        o[i].push(*n);
    }
    return o;
}
