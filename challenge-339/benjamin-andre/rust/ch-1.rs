#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn max_diff(a: &[i32]) -> i32 {
    let n = a.len();
    let mut pairs = Vec::new();

    for i in 0..n {
        for j in i + 1..n {
            pairs.push((a[i] * a[j], i, j));
        }
    }

    let mut md = 0;
    for i in 0..pairs.len() {
        for j in i + 1..pairs.len() {
            let (p1, x1, y1) = pairs[i];
            let (p2, x2, y2) = pairs[j];
            if x1 != x2 && x1 != y2 && y1 != x2 && y1 != y2 {
                md = md.max((p1 - p2).abs());
            }
        }
    }

    md
}

#[test]
fn example() {
    assert_eq!(max_diff(&[5, 9, 3, 4, 6]), 42);
    assert_eq!(max_diff(&[1, -2, 3, -4]), 10);
    assert_eq!(max_diff(&[-3, -1, -2, -4]), 10);
    assert_eq!(max_diff(&[10, 2, 0, 5, 1]), 50);
    assert_eq!(max_diff(&[7, 8, 9, 10, 10]), 44);
}
