// [dependencies]
// chrono = "0.4.19"

use chrono::{Datelike, Weekday};

#[test]
fn test_ex1() {
    assert_eq!(seizetheday(2024, 4, 3, 2), 16);
}

#[test]
fn test_ex2() {
    assert_eq!(seizetheday(2025, 10, 2, 4), 9);
}

#[test]
fn test_ex3() {
    assert_eq!(seizetheday(2026, 8, 5, 3), 0);
}

fn seizetheday(year: i32, month: u32, weekcount: u8, dayofweek: u8) -> u32 {
    match chrono::NaiveDate::from_weekday_of_month_opt(
        year,
        month,
        Weekday::try_from(dayofweek - 1).unwrap(),
        weekcount,
    ) {
        None => 0,
        Some(x) => x.day(),
    }
}
