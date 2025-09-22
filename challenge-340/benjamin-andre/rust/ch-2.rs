#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn ascending_numbers(s: &str) -> bool {
    let numbers: Vec<u32> = s
        .split_whitespace()
        .filter_map(|token| token.parse().ok())
        .collect();
    numbers.windows(2).all(|w| w[0] < w[1])
}

#[test]
fn example() {
    assert_eq!(
        ascending_numbers("The cat has 3 kittens 7 toys 10 beds"),
        true
    );
    assert_eq!(
        ascending_numbers("Alice bought 5 apples 2 oranges 9 bananas"),
        false
    );
    assert_eq!(
        ascending_numbers("I ran 1 mile 2 days 3 weeks 4 months"),
        true
    );
    assert_eq!(ascending_numbers("Bob has 10 cars 10 bikes"), false);
    assert_eq!(ascending_numbers("Zero is 0 one is 1 two is 2"), true);
}
