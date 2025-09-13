#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn highest_row(matrix: &[&[i32]]) -> i32 {
    matrix.iter().map(|row| row.iter().sum()).max().unwrap()
}

#[test]
fn example() {
    assert_eq!(
        highest_row(&[&[4, 4, 4, 4], &[10, 0, 0, 0], &[2, 2, 2, 9]]),
        16
    );
    assert_eq!(highest_row(&[&[1, 5], &[7, 3], &[3, 5]]), 10);
    assert_eq!(highest_row(&[&[1, 2, 3], &[3, 2, 1]]), 6);
    assert_eq!(highest_row(&[&[2, 8, 7], &[7, 1, 3], &[1, 9, 5]]), 17);
    assert_eq!(
        highest_row(&[&[10, 20, 30], &[5, 5, 5], &[0, 100, 0], &[25, 25, 25]]),
        100
    );
}
