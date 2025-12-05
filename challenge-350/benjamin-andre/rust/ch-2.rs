#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn shuffle_pairs(from: u64, to: u64, count: usize) -> usize {
    let same_digits = |a: u64, b: u64| {
        let mut da: Vec<char> = a.to_string().chars().collect();
        let mut db: Vec<char> = b.to_string().chars().collect();
        da.sort_unstable();
        db.sort_unstable();
        da == db
    };
    (from..=to)
        .filter(|&i| {
            let pairs = (2..=9)
                .filter(|&k| {
                    let product = i * k;
                    same_digits(i, product)
                })
                .count();
            pairs >= count
        })
        .count()
}

#[test]
fn example() {
    assert_eq!(shuffle_pairs(1, 1000, 1), 0);
    assert_eq!(shuffle_pairs(1500, 2500, 1), 3);
    assert_eq!(shuffle_pairs(1_000_000, 1_500_000, 5), 2);
    assert_eq!(shuffle_pairs(13_427_000, 14_100_000, 2), 11);
    assert_eq!(shuffle_pairs(1030, 1130, 1), 2);
}
