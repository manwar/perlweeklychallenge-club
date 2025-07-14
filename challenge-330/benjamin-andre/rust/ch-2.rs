#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn title_capital(s: &str) -> String {
    s.split_whitespace()
        .map(|word| {
            if word.len() <= 2 {
                word.to_lowercase()
            } else {
                let lower = word.to_lowercase();
                let mut chars = lower.chars();
                chars.next().unwrap().to_uppercase().collect::<String>()
                    + &chars.collect::<String>()
            }
        })
        .collect::<Vec<_>>()
        .join(" ")
}

#[test]
fn example() {
    assert_eq!(title_capital("PERL IS gREAT"), "Perl is Great");
    assert_eq!(
        title_capital("THE weekly challenge"),
        "The Weekly Challenge"
    );
    assert_eq!(title_capital("YoU ARE A stAR"), "You Are a Star");
}
