#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        flipmatrix(vec![vec![1, 1, 0], vec![1, 0, 1], vec![0, 0, 0]]),
        vec![vec![1, 0, 0], vec![0, 1, 0], vec![1, 1, 1]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        flipmatrix(vec![
            vec![1, 1, 0, 0],
            vec![1, 0, 0, 1],
            vec![0, 1, 1, 1],
            vec![1, 0, 1, 0]
        ]),
        vec![
            vec![1, 1, 0, 0],
            vec![0, 1, 1, 0],
            vec![0, 0, 0, 1],
            vec![1, 0, 1, 0]
        ]
    );
}

fn flipmatrix(a: Vec<Vec<u8>>) -> Vec<Vec<u8>> {
    let mut b = Vec::new();
    for row in a {
        let mut r2 = row.into_iter().map(|i| 1 - i).collect::<Vec<_>>();
        r2.reverse();
        b.push(r2);
    }
    b
}
