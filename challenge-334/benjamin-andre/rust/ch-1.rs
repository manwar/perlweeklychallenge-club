#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn range_sum(ints: &[i32], x: usize, y: usize) -> i32 {
    ints[x..=y].iter().sum()
}

#[test]
fn example() {
    assert_eq!(range_sum(&[-2, 0, 3, -5, 2, -1], 0, 2), 1);
    assert_eq!(range_sum(&[1, -2, 3, -4, 5], 1, 3), -3);
    assert_eq!(range_sum(&[1, 0, 2, -1, 3], 3, 4), 2);
    assert_eq!(range_sum(&[-5, 4, -3, 2, -1, 0], 0, 3), -2);
    assert_eq!(range_sum(&[-1, 0, 2, -3, -2, 1], 0, 2), 1);
}
