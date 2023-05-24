#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        matrixscore(vec![vec![0, 0, 1, 1], vec![1, 0, 1, 0], vec![1, 1, 1, 0]]),
        39
    );
}

#[test]
fn test_ex2() {
    assert_eq!(matrixscore(vec![vec![0]]), 1);
}

fn matrixscore(matrix0: Vec<Vec<u8>>) -> u32 {
    let mut matrix = matrix0;
    for i in 0..matrix.len() {
        if matrix[i][0] == 0 {
            for j in 0..matrix[i].len() {
                matrix[i][j] = 1 - matrix[i][j];
            }
        }
    }
    let t = matrix.len() / 2;
    for i in 1..matrix[0].len() {
        let mut c = 0;
        for j in 0..matrix.len() {
            if matrix[j][i] == 0 {
                c += 1;
            }
        }
        if c > t {
            for j in 0..matrix.len() {
                matrix[j][i] = 1 - matrix[j][i];
            }
        }
    }
    let mut tot = 0;
    for m in matrix {
        let mut p = 0;
        for n in m {
            p *= 2;
            if n == 1 {
                p += 1;
            }
        }
        tot += p;
    }
    tot
}
