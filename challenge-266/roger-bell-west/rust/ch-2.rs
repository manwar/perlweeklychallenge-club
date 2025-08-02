#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        xmatrix(vec![
            vec![1, 0, 0, 2],
            vec![0, 3, 4, 0],
            vec![0, 5, 6, 0],
            vec![7, 0, 0, 1]
        ]),
        true
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        xmatrix(vec![vec![1, 2, 3], vec![4, 5, 6], vec![7, 8, 9]]),
        false
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        xmatrix(vec![vec![1, 0, 2], vec![0, 3, 0], vec![4, 0, 5]]),
        true
    );
}

fn xmatrix(a: Vec<Vec<u32>>) -> bool {
    let order = a.len() - 1;
    let mut valid = true;
    for (y, row) in a.iter().enumerate() {
        for (x, &value) in row.iter().enumerate() {
            if x == y || x == order - y {
                if value == 0 {
                    valid = false;
                }
            } else {
                if value != 0 {
                    valid = false;
                }
            }
            if !valid {
                break;
            }
        }
        if !valid {
            break;
        }
    }
    valid
}
