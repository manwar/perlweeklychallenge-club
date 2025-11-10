#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn format_phone_number(phone: &str) -> String {
    let digits: String = phone.chars().filter(|c| c.is_ascii_digit()).collect();
    let mut result = Vec::new();
    let mut i = 0;
    while i < digits.len() {
        let remaining = digits.len() - i;
        let block_size = if remaining <= 4 && remaining != 3 {
            2
        } else {
            3
        };
        result.push(&digits[i..i + block_size]);
        i += block_size;
    }
    result.join("-")
}

#[test]
fn example() {
    assert_eq!(format_phone_number("1-23-45-6"), "123-456");
    assert_eq!(format_phone_number("1234"), "12-34");
    assert_eq!(format_phone_number("12 345-6789"), "123-456-789");
    assert_eq!(format_phone_number("123 4567"), "123-45-67");
    assert_eq!(format_phone_number("123 456-78"), "123-456-78");
}
