#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        straightline(vec![vec![2., 1.], vec![2., 3.], vec![2., 5.]]),
        true
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        straightline(vec![vec![1., 4.], vec![3., 4.], vec![10., 4.]]),
        true
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        straightline(vec![vec![0., 0.], vec![1., 1.], vec![2., 3.]]),
        false
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        straightline(vec![vec![1., 1.], vec![1., 1.], vec![1., 1.]]),
        true
    );
}

fn straightline(a: Vec<Vec<f64>>) -> bool {
    let mut b = a.clone();
    b.sort_by(|a, b| a.partial_cmp(b).unwrap());
    b.dedup();
    if b.len() < 3 {
        return true;
    }
    // x = p + qn; y = r + sn
    let p = b[0][0];
    let q = b[1][0] - b[0][0];
    let r = b[0][1];
    let s = b[1][1] - b[0][1];
    for tpair in b.iter().skip(2) {
        if q == 0. && tpair[0] != b[0][0] {
            return false;
        }
        if s == 0. && tpair[1] != b[0][1] {
            return false;
        }
        if q != 0. && s != 0. {
            let n1 = (tpair[0] - p) / q;
            let n2 = (tpair[1] - r) / s;
            if n1 != n2 {
                return false;
            }
        }
    }
    true
}
