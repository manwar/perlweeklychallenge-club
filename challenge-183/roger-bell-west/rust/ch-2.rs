#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

// [dependencies]
// chrono = "0.4.19"

use chrono::{Datelike, NaiveDate};

#[test]
fn test_ex1() {
    assert_eq!(datedifference("2019-02-10", "2022-11-01"), [3, 264]);
}

#[test]
fn test_ex2() {
    assert_eq!(datedifference("2020-09-15", "2022-03-29"), [1, 195]);
}

fn datedifference(d1s: &str, d2s: &str) -> [usize; 2] {
    let mut d1 = NaiveDate::parse_from_str(d1s, "%Y-%m-%d").unwrap();
    let mut d2 = NaiveDate::parse_from_str(d2s, "%Y-%m-%d").unwrap();
    if d1 > d2 {
        let t = d1;
        d1 = d2;
        d2 = t;
    }
    let mut yd = d2.year() - d1.year();
    let mut inter = NaiveDate::from_ymd(d2.year(), d1.month(), d1.day());
    if d1.month() > d2.month()
        || (d1.month() == d2.month() && d1.day() > d2.day())
    {
        inter = NaiveDate::from_ymd(d2.year() - 1, d1.month(), d1.day());
        yd -= 1;
    }
    [yd.try_into().unwrap(), (d2 - inter).num_days().try_into().unwrap()]
}
