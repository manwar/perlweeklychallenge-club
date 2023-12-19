#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(submatrixsum(vec![vec![1, 2, 3, 4], vec![5, 6, 7, 8], vec![9, 10, 11, 12]]), vec![vec![14, 18, 22], vec![30, 34, 38]]);
}

#[test]
fn test_ex2() {
    assert_eq!(submatrixsum(vec![vec![1, 0, 0, 0], vec![0, 1, 0, 0], vec![0, 0, 1, 0], vec![0, 0, 0, 1]]), vec![vec![2, 1, 0], vec![1, 2, 1], vec![0, 1, 2]]);
}

fn submatrixsum(a: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut out = Vec::new();
    for y in 0 .. a.len() - 1 {
        let mut row = Vec::new();
        for x in 0 .. a[0].len() - 1 {
            let mut s = 0;
            for ya in y ..= y + 1 {
                for xa in x ..= x + 1 {
                    s += a[ya][xa];
                }
            }
            row.push(s);
        }
        out.push(row);
    }
    out
}
