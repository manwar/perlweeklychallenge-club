#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(arithmetictriplets(vec![0, 1, 4, 6, 7, 10], 3), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(arithmetictriplets(vec![4, 5, 6, 7, 8, 9], 2), 2);
}

fn arithmetictriplets(nums: Vec<u32>, diff: u32) -> u32 {
    let ns = nums.iter().collect::<HashSet<_>>();
    nums.iter()
        .filter(|&&n| ns.contains(&(n + diff)) && ns.contains(&(n + 2 * diff)))
        .count() as u32
}
