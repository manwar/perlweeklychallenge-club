#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn array_form_compute(ints: &[i32], x: i32) -> Vec<i32> {
    let num: i64 = ints.iter().fold(0, |acc, &d| acc * 10 + d as i64);
    let sum = num + x as i64;
    sum.to_string()
        .chars()
        .map(|c| c.to_digit(10).unwrap() as i32)
        .collect()
}

#[test]
fn example() {
    assert_eq!(array_form_compute(&[1, 2, 3, 4], 12), vec![1, 2, 4, 6]);
    assert_eq!(array_form_compute(&[2, 7, 4], 181), vec![4, 5, 5]);
    assert_eq!(array_form_compute(&[9, 9, 9], 1), vec![1, 0, 0, 0]);
    assert_eq!(
        array_form_compute(&[1, 0, 0, 0, 0], 9999),
        vec![1, 9, 9, 9, 9]
    );
    assert_eq!(array_form_compute(&[0], 1000), vec![1, 0, 0, 0]);
}
