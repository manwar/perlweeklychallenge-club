#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::cmp::max;

#[test]
fn test_ex1() {
    assert_eq!(
        maximalsquare(vec![
            vec![1, 0, 1, 0, 0],
            vec![1, 0, 1, 1, 1],
            vec![1, 1, 1, 1, 1],
            vec![1, 0, 0, 1, 0]
        ]),
        4
    );
}

#[test]
fn test_ex2() {
    assert_eq!(maximalsquare(vec![vec![0, 1], vec![1, 0]]), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(maximalsquare(vec![vec![0]]), 0);
}

fn maximalsquare(a: Vec<Vec<u8>>) -> usize {
    let mut mx = 0;
    let boundy = a.len();
    let boundx = a[0].len();
    for y in 0..boundy {
        for x in 0..boundx {
            let mut size = 0;
            loop {
                let mut tests: Vec<(usize, usize)> = Vec::new();
                tests.append(
                    &mut (x..=x + size)
                        .map(|xx| (y + size, xx))
                        .collect::<Vec<_>>(),
                );
                if size > 0 {
                    tests.append(
                        &mut (y..=y + size - 1)
                            .map(|yy| (yy, x + size))
                            .collect::<Vec<_>>(),
                    );
                }
                if tests.iter().map(|(yy, xx)| a[*yy][*xx]).any(|n| n == 0) {
                    break;
                }
                size += 1;
                if x + size >= boundx || y + size >= boundy {
                    break;
                }
            }
            mx = max(mx, size * size);
        }
    }
    mx
}
