// [dependencies]
// chrono = "0.4.34"

use chrono::{Datelike, NaiveDate};
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        bankingdayoffset("2018-06-28", 3, vec!["2018-07-03"]),
        "2018-07-04"
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        bankingdayoffset("2018-06-28", 3, Vec::<&str>::new()),
        "2018-07-03"
    );
}

fn parsedate(s: &str) -> NaiveDate {
    NaiveDate::parse_from_str(s, "%Y-%m-%d").unwrap()
}

fn bankingdayoffset(
    start: &str,
    offset: u32,
    bankholidays: Vec<&str>,
) -> String {
    let bh = bankholidays.iter().map(|i| parsedate(i)).collect::<HashSet<_>>();
    let mut d = parsedate(start);
    for _ in 0..offset {
        d = d.succ_opt().unwrap();
        while bh.contains(&d) || d.weekday().num_days_from_monday() > 4 {
            d = d.succ_opt().unwrap();
        }
    }
    d.format("%Y-%m-%d").to_string()
}
