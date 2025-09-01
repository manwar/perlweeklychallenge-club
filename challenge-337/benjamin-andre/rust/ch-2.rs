#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn odd_matrix(row: usize, col: usize, locations: &[[usize; 2]]) -> i32 {
    let mut row_counts = vec![0; row];
    let mut col_counts = vec![0; col];
    for &[r, c] in locations {
        row_counts[r] += 1;
        col_counts[c] += 1;
    }
    (0..row)
        .map(|r| {
            (0..col)
                .filter(|&c| (row_counts[r] + col_counts[c]) % 2 == 1)
                .count()
        })
        .sum::<usize>() as i32
}

#[test]
fn example() {
    assert_eq!(odd_matrix(2, 3, &[[0, 1], [1, 1]]), 6);
    assert_eq!(odd_matrix(2, 2, &[[1, 1], [0, 0]]), 0);
    assert_eq!(odd_matrix(3, 3, &[[0, 0], [1, 2], [2, 1]]), 0);
    assert_eq!(odd_matrix(1, 5, &[[0, 2], [0, 4]]), 2);
    assert_eq!(odd_matrix(4, 2, &[[1, 0], [3, 1], [2, 0], [0, 1]]), 8);
}
