#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(ci(vec![vec![1,4],vec![3,5],vec![6,8],vec![12,13],vec![3,20]]),vec![vec![3,5],vec![3,20]]);
}

#[test]
fn test_ex2() {
    assert_eq!(ci(vec![vec![3,4],vec![5,7],vec![6,9],vec![10,12],vec![13,15]]),vec![vec![6,9]]);
}

fn ci(a: Vec<Vec<i64>>) -> Vec<Vec<i64>> {
    let mut o: Vec<Vec<i64>>=vec![];
    for i in 1..a.len() {
        for j in 0..i {
            if (a[i][0] >= a[j][0] && a[i][0] <= a[j][1]) ||
                (a[i][1] >= a[j][0] && a[i][1] <= a[j][1]) ||
                (a[i][0] <= a[j][0] && a[i][1] >= a[j][1]) {
                    o.push(a[i].clone());
                    break;
                }
        }
    }
    return o
}
