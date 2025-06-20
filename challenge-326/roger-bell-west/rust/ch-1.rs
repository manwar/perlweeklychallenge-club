use chrono::{Datelike, NaiveDate};

#[test]
fn test_ex1() {
    assert_eq!(dayoftheyear("2025-02-02"), 33);
}

#[test]
fn test_ex2() {
    assert_eq!(dayoftheyear("2025-04-10"), 100);
}

#[test]
fn test_ex3() {
    assert_eq!(dayoftheyear("2025-09-07"), 250);
}

fn dayoftheyear(a: &str) -> u32 {
    NaiveDate::parse_from_str(a, "%Y-%m-%d").unwrap().ordinal()
}
