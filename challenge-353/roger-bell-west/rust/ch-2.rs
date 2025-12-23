use regex::Regex;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        validatecoupon(
            vec!["A123", "B_456", "C789", "D@1", "E123"],
            vec![
                "electronics",
                "restaurant",
                "electronics",
                "pharmacy",
                "grocery"
            ],
            vec![true, false, true, true, true]
        ),
        vec![true, false, true, false, true]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        validatecoupon(
            vec!["Z_9", "AB_12", "G01", "X99", "test"],
            vec![
                "pharmacy",
                "electronics",
                "grocery",
                "electronics",
                "unknown"
            ],
            vec![true, true, false, true, true]
        ),
        vec![true, true, false, true, false]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        validatecoupon(
            vec!["_123", "123", "", "Coupon_A", "Alpha"],
            vec![
                "restaurant",
                "electronics",
                "electronics",
                "pharmacy",
                "grocery"
            ],
            vec![true, true, false, true, true]
        ),
        vec![true, true, false, true, true]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        validatecoupon(
            vec!["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
            vec!["electronics", "electronics", "grocery", "grocery"],
            vec![true, true, true, true]
        ),
        vec![true, true, true, true]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        validatecoupon(
            vec!["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
            vec![
                "restaurant",
                "electronics",
                "grocery",
                "pharmacy",
                "electronics"
            ],
            vec![true, true, true, true, false]
        ),
        vec![true, true, true, true, false]
    );
}

fn validatecoupon(
    codes: Vec<&str>,
    names: Vec<&str>,
    status: Vec<bool>,
) -> Vec<bool> {
    let rx = Regex::new("^[0-9A-Za-z_]+$").unwrap();
    let dep =
        HashSet::from(["electronics", "grocery", "pharmacy", "restaurant"]);
    (0..codes.len()).map(|i| rx.is_match(codes[i]) && dep.contains(names[i]) && status[i]).collect::<Vec<_>>()
}
