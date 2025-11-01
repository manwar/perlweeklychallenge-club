#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn peak_positions(ints: &[i32]) -> Vec<usize> {
    (0..ints.len())
        .filter(|&i| {
            let left_ok = i == 0 || ints[i] > ints[i - 1];
            let right_ok = i == ints.len() - 1 || ints[i] > ints[i + 1];
            left_ok && right_ok && !(i == 0 && i == ints.len() - 1)
        })
        .collect()
}

#[test]
fn example() {
    assert_eq!(peak_positions(&[1, 3, 2]), vec![1]);
    assert_eq!(peak_positions(&[2, 4, 6, 5, 3]), vec![2]);
    assert_eq!(peak_positions(&[1, 2, 3, 2, 4, 1]), vec![2, 4]);
    assert_eq!(peak_positions(&[5, 3, 1]), vec![0]);
    assert_eq!(peak_positions(&[1, 5, 1, 5, 1, 5, 1]), vec![1, 3, 5]);
}
