#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn convert_time(source: &str, target: &str) -> i32 {
    let to_minutes = |s: &str| {
        let parts: Vec<_> = s.split(':').collect();
        parts[0].parse::<i32>().unwrap() * 60 + parts[1].parse::<i32>().unwrap()
    };
    let mut diff = (to_minutes(target) - to_minutes(source) + 1440) % 1440;
    let mut ops = 0;
    for &step in &[60, 15, 5, 1] {
        ops += diff / step;
        diff %= step;
    }
    ops
}

#[test]
fn example() {
    assert_eq!(convert_time("02:30", "02:45"), 1);
    assert_eq!(convert_time("11:55", "12:15"), 2);
    assert_eq!(convert_time("09:00", "13:00"), 4);
    assert_eq!(convert_time("23:45", "00:30"), 3);
    assert_eq!(convert_time("14:20", "15:25"), 2);
}
