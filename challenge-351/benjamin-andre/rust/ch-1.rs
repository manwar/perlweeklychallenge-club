#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn special_average(ints: &[i32]) -> i32 {
    let min = *ints.iter().min().unwrap();
    let max = *ints.iter().max().unwrap();
    let filtered: Vec<i32> = ints
        .iter()
        .copied()
        .filter(|&x| x != min && x != max)
        .collect();
    if filtered.is_empty() {
        0
    } else {
        filtered.iter().sum::<i32>() / filtered.len() as i32
    }
}

#[test]
fn example() {
    assert_eq!(special_average(&[8000, 5000, 6000, 2000, 3000, 7000]), 5250);
    assert_eq!(special_average(&[100_000, 80_000, 110_000, 90_000]), 95_000);
    assert_eq!(special_average(&[2500, 2500, 2500, 2500]), 0);
    assert_eq!(special_average(&[2000]), 0);
    assert_eq!(special_average(&[1000, 2000, 3000, 4000, 5000, 6000]), 3500);
}
