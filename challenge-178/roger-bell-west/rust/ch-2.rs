#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

// [dependencies]
// chrono = "0.4.19"

use chrono::{Datelike, Duration, NaiveDateTime, Timelike};

#[test]
fn test_ex1() {
    assert_eq!(
        addbizhours("2022-08-01 10:30", 4.0),
        "2022-08-01 14:30".to_string()
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        addbizhours("2022-08-01 17:00", 3.5),
        "2022-08-02 11:30".to_string()
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        addbizhours("2022-08-01 18:00", 3.5),
        "2022-08-02 12:30".to_string()
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        addbizhours("2022-08-01 19:00", 3.5),
        "2022-08-02 12:30".to_string()
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        addbizhours("2022-08-05 17:00", 3.5),
        "2022-08-08 11:30".to_string()
    );
}

#[test]
fn test_ex6() {
    assert_eq!(
        addbizhours("2022-08-01 12:00", 18.0),
        "2022-08-03 12:00".to_string()
    );
}

fn addbizhours(start: &str, delta: f64) -> String {
    let mut current =
        NaiveDateTime::parse_from_str(start, "%Y-%m-%d %H:%M").unwrap();
    let mut seconds = (3600. * delta) as i64;
    let bizdaylength = 3600 * 9;
    if !isbiz(current) {
        current = nextbizstart(current);
    }
    let ed = nextbizend(current);
    let remain = (ed - current).num_seconds();
    if remain < seconds {
        seconds -= remain;
        current = nextbizstart(ed);
        while seconds > bizdaylength {
            current = nextbizstart(current);
            seconds -= bizdaylength;
        }
    }
    current += Duration::seconds(seconds);
    current.format("%Y-%m-%d %H:%M").to_string()
}

fn isbiz(tm: NaiveDateTime) -> bool {
    if tm.weekday().num_days_from_monday() > 4 {
        return false;
    }
    if tm.hour() < 9 || tm.hour() >= 18 {
        return false;
    }
    true
}

fn nextbizstart(tm0: NaiveDateTime) -> NaiveDateTime {
    let mut tm = tm0.clone();
    while tm.weekday().num_days_from_monday() > 4 {
        tm = tm.date().succ().and_hms(9, 0, 0);
    }
    if tm.hour() < 9 {
        tm = tm.date().and_hms(9, 0, 0);
    } else {
        loop {
            tm = tm.date().succ().and_hms(9, 0, 0);
            if tm.weekday().num_days_from_monday() <= 4 {
                break;
            }
        }
    }
    tm
}

fn nextbizend(tm0: NaiveDateTime) -> NaiveDateTime {
    let mut tm = tm0.clone();
    while tm.weekday().num_days_from_monday() > 4 {
        tm = tm.date().succ().and_hms(18, 0, 0);
    }
    if tm.hour() >= 18 {
        loop {
            tm = tm.date().succ().and_hms(18, 0, 0);
            if tm.weekday().num_days_from_monday() <= 4 {
                break;
            }
        }
    } else {
        tm = tm.date().and_hms(18, 0, 0);
    }
    tm
}
