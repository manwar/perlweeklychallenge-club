#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn max_distance(arr1: &[i32], arr2: &[i32]) -> i32 {
    let min1 = *arr1.iter().min().unwrap();
    let max1 = *arr1.iter().max().unwrap();
    let min2 = *arr2.iter().min().unwrap();
    let max2 = *arr2.iter().max().unwrap();
    std::cmp::max((max1 - min2).abs(), (max2 - min1).abs())
}

#[test]
fn example() {
    assert_eq!(max_distance(&[4, 5, 7], &[9, 1, 3, 4]), 6);
    assert_eq!(max_distance(&[2, 3, 5, 4], &[3, 2, 5, 5, 8, 7]), 6);
    assert_eq!(max_distance(&[2, 1, 11, 3], &[2, 5, 10, 2]), 9);
    assert_eq!(max_distance(&[1, 2, 3], &[3, 2, 1]), 2);
    assert_eq!(max_distance(&[1, 0, 2, 3], &[5, 0]), 5);
}
