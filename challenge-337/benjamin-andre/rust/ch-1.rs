#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn smaller_than_current(nums: &[i32]) -> Vec<i32> {
    nums.iter()
        .map(|&x| nums.iter().filter(|&&y| y <= x).count() as i32 - 1)
        .collect()
}

#[test]
fn example() {
    assert_eq!(smaller_than_current(&[6, 5, 4, 8]), vec![2, 1, 0, 3]);
    assert_eq!(smaller_than_current(&[7, 7, 7, 7]), vec![3, 3, 3, 3]);
    assert_eq!(smaller_than_current(&[5, 4, 3, 2, 1]), vec![4, 3, 2, 1, 0]);
    assert_eq!(
        smaller_than_current(&[-1, 0, 3, -2, 1]),
        vec![1, 2, 4, 0, 3]
    );
    assert_eq!(smaller_than_current(&[0, 1, 1, 2, 0]), vec![1, 3, 3, 4, 1]);
}
