// [dependencies]
// chrono = "0.4.19"

use chrono::NaiveDate;

#[test]
fn text_ex1() {
    assert_eq!(daystogether(["12-01", "20-01"], ["15-01", "18-01"]), 4);
}

#[test]
fn text_ex2() {
    assert_eq!(daystogether(["02-03", "12-03"], ["13-03", "14-03"]), 0);
}

#[test]
fn text_ex3() {
    assert_eq!(daystogether(["02-03", "12-03"], ["11-03", "15-03"]), 2);
}

#[test]
fn text_ex4() {
    assert_eq!(daystogether(["30-03", "05-04"], ["28-03", "02-04"]), 4);
}

fn s2date(ds: &str) -> NaiveDate {
    NaiveDate::parse_from_str(&(ds.to_owned() + "-2022"), "%d-%m-%Y").unwrap()
}

fn daystogether(a: [&str; 2], b: [&str; 2]) -> usize {
    let mut starts = vec![s2date(a[0]), s2date(b[0])];
    starts.sort();
    let mut ends = vec![s2date(a[1]), s2date(b[1])];
    ends.sort();
    if ends[0] >= starts[1] {
        (ends[0] - starts[1]).num_days() as usize + 1
    } else {
        0
    }
}
