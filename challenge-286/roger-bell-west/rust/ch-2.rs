#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(ordergame(vec![2, 1, 4, 5, 6, 3, 0, 2]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(ordergame(vec![0, 5, 3, 2]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(
        ordergame(vec![9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]),
        2
    );
}

fn ordergame(a: Vec<u32>) -> u32 {
    let mut p = a;
    while p.len() > 1 {
        let mut q = Vec::new();
        let mut mm = true;
        for j in p.windows(2) {
            if mm {
                q.push(j[0].min(j[1]));
            } else {
                q.push(j[0].max(j[1]));
            }
            mm = !mm;
        }
        p = q;
    }
    p[0]
}
