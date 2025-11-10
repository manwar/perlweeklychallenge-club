#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn format_date(s: &str) -> String {
    let months = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    let parts: Vec<_> = s.split_whitespace().collect();
    let day: u32 = parts[0]
        .chars()
        .filter(|c| c.is_ascii_digit())
        .collect::<String>()
        .parse()
        .unwrap();
    let month = months.iter().position(|&m| m == parts[1]).unwrap() + 1;
    let year = parts[2];
    format!("{}-{:02}-{:02}", year, month, day)
}

#[test]
fn example() {
    assert_eq!(format_date("1st Jan 2025"), "2025-01-01");
    assert_eq!(format_date("22nd Feb 2025"), "2025-02-22");
    assert_eq!(format_date("15th Apr 2025"), "2025-04-15");
    assert_eq!(format_date("23rd Oct 2025"), "2025-10-23");
    assert_eq!(format_date("31st Dec 2025"), "2025-12-31");
}
