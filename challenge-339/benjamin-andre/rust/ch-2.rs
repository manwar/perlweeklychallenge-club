#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn peak_point(gain: &[i32]) -> i32 {
    let mut altitude = 0;
    let mut peak = 0;
    for &g in gain {
        altitude += g;
        peak = peak.max(altitude);
    }
    peak
}

#[test]
fn example() {
    assert_eq!(peak_point(&[-5, 1, 5, -9, 2]), 1);
    assert_eq!(peak_point(&[10, 10, 10, -25]), 30);
    assert_eq!(peak_point(&[3, -4, 2, 5, -6, 1]), 6);
    assert_eq!(peak_point(&[-1, -2, -3, -4]), 0);
    assert_eq!(peak_point(&[-10, 15, 5]), 10);
}
