#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn binary_date(date: &str) -> String {
    date.split('-')
        .map(|part| format!("{:b}", part.parse::<u32>().unwrap()))
        .collect::<Vec<_>>()
        .join("-")
}

#[test]
fn example() {
    assert_eq!(binary_date("2025-07-26"), "11111101001-111-11010");
    assert_eq!(binary_date("2000-02-02"), "11111010000-10-10");
    assert_eq!(binary_date("2024-12-31"), "11111101000-1100-11111");
}
