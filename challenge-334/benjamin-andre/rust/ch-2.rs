#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn nearest_valid_point(x: i32, y: i32, points: &[[i32; 2]]) -> i32 {
    points
        .iter()
        .enumerate()
        .filter(|(_, &[px, py])| px == x || py == y)
        .map(|(i, &[px, py])| (i, (x - px).abs() + (y - py).abs()))
        .min_by_key(|&(_, dist)| dist)
        .map_or(-1, |(i, _)| i as i32)
}

#[test]
fn example() {
    assert_eq!(
        nearest_valid_point(3, 4, &[[1, 2], [3, 1], [2, 4], [2, 3]]),
        2
    );
    assert_eq!(
        nearest_valid_point(2, 5, &[[3, 4], [2, 3], [1, 5], [2, 5]]),
        3
    );
    assert_eq!(nearest_valid_point(1, 1, &[[2, 2], [3, 3], [4, 4]]), -1);
    assert_eq!(
        nearest_valid_point(0, 0, &[[0, 1], [1, 0], [0, 2], [2, 0]]),
        0
    );
    assert_eq!(
        nearest_valid_point(5, 5, &[[5, 6], [6, 5], [5, 4], [4, 5]]),
        0
    );
}
