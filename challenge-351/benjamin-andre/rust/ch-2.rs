#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn arithmetic_progression(nums: &[f64]) -> bool {
    if nums.len() <= 2 {
        return true;
    }
    let mut sorted = nums.to_vec();
    sorted.sort_by(|a, b| a.partial_cmp(b).unwrap());
    let diff = sorted[1] - sorted[0];
    sorted.windows(2).all(|w| (w[1] - w[0] - diff).abs() < 1e-9)
}

#[test]
fn example() {
    assert_eq!(arithmetic_progression(&[1.0, 3.0, 5.0, 7.0, 9.0]), true);
    assert_eq!(arithmetic_progression(&[9.0, 1.0, 7.0, 5.0, 3.0]), true);
    assert_eq!(arithmetic_progression(&[1.0, 2.0, 4.0, 8.0, 16.0]), false);
    assert_eq!(arithmetic_progression(&[5.0, -1.0, 3.0, 1.0, -3.0]), true);
    assert_eq!(arithmetic_progression(&[1.5, 3.0, 0.0, 4.5, 6.0]), true);
}
