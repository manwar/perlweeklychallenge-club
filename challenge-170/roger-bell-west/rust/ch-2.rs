#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        kronecker(vec![vec![1, 2], vec![3, 4]], vec![vec![5, 6], vec![7, 8]]),
        vec![
            vec![5, 6, 10, 12],
            vec![7, 8, 14, 16],
            vec![15, 18, 20, 24],
            vec![21, 24, 28, 32]
        ]
    );
}

fn kronecker(a: Vec<Vec<usize>>, b: Vec<Vec<usize>>) -> Vec<Vec<usize>> {
    let mut o = Vec::new();
    let ax = a[0].len();
    let ay = a.len();
    let bx = b[0].len();
    let by = b.len();
    for y in 0..ay * by {
        let byi = y % by;
        let ayi = y / by;
        let mut row = Vec::new();
        for x in 0..ax * bx {
            let bxi = x % bx;
            let axi = x / bx;
            row.push(a[ayi][axi] * b[byi][bxi]);
        }
        o.push(row);
    }
    o
}
