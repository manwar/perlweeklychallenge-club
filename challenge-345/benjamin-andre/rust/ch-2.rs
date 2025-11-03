#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn last_visitor(ints: &[i32]) -> Vec<i32> {
    let mut seen = Vec::new();
    let mut ans = Vec::new();
    let mut neg_count = 0;
    for &n in ints {
        if n > 0 {
            seen.insert(0, n);
            neg_count = 0;
        } else {
            if neg_count < seen.len() {
                ans.push(seen[neg_count]);
            } else {
                ans.push(-1);
            }
            neg_count += 1;
        }
    }
    ans
}

#[test]
fn example() {
    assert_eq!(last_visitor(&[5, -1, -1]), vec![5, -1]);
    assert_eq!(last_visitor(&[3, 7, -1, -1, -1]), vec![7, 3, -1]);
    assert_eq!(last_visitor(&[2, -1, 4, -1, -1]), vec![2, 4, 2]);
    assert_eq!(last_visitor(&[10, 20, -1, 30, -1, -1]), vec![20, 30, 20]);
    assert_eq!(last_visitor(&[-1, -1, 5, -1]), vec![-1, -1, 5]);
}
