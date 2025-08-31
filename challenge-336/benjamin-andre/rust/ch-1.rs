#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn equal_group(ints: &[i32]) -> bool {
    let mut counts = std::collections::HashMap::new();
    for &n in ints {
        *counts.entry(n).or_insert(0) += 1;
    }
    let frequencies: Vec<_> = counts.values().collect();
    if frequencies.is_empty() || frequencies.iter().any(|&&c| c < 2) {
        return false;
    }
    let gcd = frequencies
        .iter()
        .fold(**frequencies.first().unwrap(), |acc, &&x| {
            fn gcd(a: usize, b: usize) -> usize {
                if b == 0 {
                    a
                } else {
                    gcd(b, a % b)
                }
            }
            gcd(acc, x)
        });
    gcd >= 2
}

#[test]
fn example() {
    assert_eq!(equal_group(&[1, 1, 2, 2, 2, 2]), true);
    assert_eq!(equal_group(&[1, 1, 1, 2, 2, 2, 3, 3]), false);
    assert_eq!(equal_group(&[5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7]), true);
    assert_eq!(equal_group(&[1, 2, 3, 4]), false);
    assert_eq!(equal_group(&[8, 8, 9, 9, 10, 10, 11, 11]), true);
}
