use chrono::{Datelike, Duration, TimeZone, Utc};

// [dependencies]
// chrono = "0.4.19"

#[test]
fn test_ex1() {
    assert_eq!(
        lastsunday(2022),
        vec![
            "2022-01-30",
            "2022-02-27",
            "2022-03-27",
            "2022-04-24",
            "2022-05-29",
            "2022-06-26",
            "2022-07-31",
            "2022-08-28",
            "2022-09-25",
            "2022-10-30",
            "2022-11-27",
            "2022-12-25"
        ]
    );
}

fn lastsunday(year0: i32) -> Vec<String> {
    let mut year = year0;
    let mut o = Vec::new();
    for month0 in 2..=13 {
        let mut month = month0;
        if month0 == 13 {
            year += 1;
            month -= 12;
        }
        let mut dt = Utc.ymd(year, month, 1) - Duration::days(1);
        let dl = dt.weekday().num_days_from_sunday();
        dt = dt - Duration::days(dl.into());
        o.push(dt.format("%Y-%m-%d").to_string());
    }
    o
}
