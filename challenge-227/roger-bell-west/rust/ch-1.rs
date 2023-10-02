// [dependencies]
// chrono = "0.4.19"

use chrono::Datelike;

#[test]
fn test_ex1() {
    assert_eq!(friday13th(2023), 2);
}

fn friday13th(y: i32) -> u32 {
    let mut f = 0;
    for m in 1..=12 {
        if chrono::NaiveDate::from_ymd_opt(y, m as u32, 13)
            .unwrap()
            .weekday()
            .number_from_monday()
            == 5
        {
            f += 1;
        }
    }
    f
}
