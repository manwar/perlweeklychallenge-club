#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn binary_prefix(nums: &[u8]) -> Vec<bool> {
    let mut value = 0;
    nums.iter()
        .map(|&bit| {
            value = (value * 2 + bit as i32) % 5;
            value == 0
        })
        .collect()
}

#[test]
fn example() {
    assert_eq!(
        binary_prefix(&[0, 1, 1, 0, 0, 1, 0, 1, 1, 1]),
        vec![true, false, false, false, false, true, true, false, false, false]
    );
    assert_eq!(
        binary_prefix(&[1, 0, 1, 0, 1, 0]),
        vec![false, false, true, true, false, false]
    );
    assert_eq!(
        binary_prefix(&[0, 0, 1, 0, 1]),
        vec![true, true, false, false, true]
    );
    assert_eq!(
        binary_prefix(&[1, 1, 1, 1, 1]),
        vec![false, false, false, true, false]
    );
    assert_eq!(
        binary_prefix(&[1, 0, 1, 1, 0, 1, 0, 0, 1, 1]),
        vec![false, false, true, false, false, true, true, true, false, false]
    );
}
