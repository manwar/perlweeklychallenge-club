#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn duplicate_zeros(ints: &[i32]) -> Vec<i32> {
    let mut result = Vec::new();
    for &n in ints {
        if n == 0 {
            result.push(0);
            result.push(0);
        } else {
            result.push(n);
        }
    }
    result.truncate(ints.len());
    result
}

#[test]
fn example() {
    assert_eq!(
        duplicate_zeros(&[1, 0, 2, 3, 0, 4, 5, 0]),
        vec![1, 0, 0, 2, 3, 0, 0, 4]
    );
    assert_eq!(duplicate_zeros(&[1, 2, 3]), vec![1, 2, 3]);
    assert_eq!(duplicate_zeros(&[1, 2, 3, 0]), vec![1, 2, 3, 0]);
    assert_eq!(duplicate_zeros(&[0, 0, 1, 2]), vec![0, 0, 0, 0]);
    assert_eq!(duplicate_zeros(&[1, 2, 0, 3, 4]), vec![1, 2, 0, 0, 3]);
}
