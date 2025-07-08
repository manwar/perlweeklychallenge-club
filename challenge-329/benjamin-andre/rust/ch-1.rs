#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

use std::collections::HashSet;

fn counter_integer(s: &str) -> Vec<i32> {
    let mut res: Vec<i32> = s
        .split(|c: char| !c.is_ascii_digit())
        .filter_map(|num_str| num_str.parse().ok())
        .collect::<HashSet<_>>()
        .into_iter()
        .collect();
    res.sort();
    res
}

#[test]
fn example() {
    assert_eq!(counter_integer("the1weekly2challenge2"), vec![1, 2]);
    assert_eq!(counter_integer("go21od1lu5c7k"), vec![1, 5, 7, 21]);
    assert_eq!(counter_integer("4p3e2r1l"), vec![1, 2, 3, 4]);
}
