#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(ascendingnumbers("The cat has 3 kittens 7 toys 10 beds"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(
        ascendingnumbers("Alice bought 5 apples 2 oranges 9 bananas"),
        false
    );
}

#[test]
fn test_ex3() {
    assert_eq!(ascendingnumbers("I ran 1 mile 2 days 3 weeks 4 months"), true);
}

#[test]
fn test_ex4() {
    assert_eq!(ascendingnumbers("Bob has 10 cars 10 bikes"), false);
}

#[test]
fn test_ex5() {
    assert_eq!(ascendingnumbers("Zero is 0 one is 1 two is 2"), true);
}

fn ascendingnumbers(a: &str) -> bool {
    let mut prev: Option<u32> = None;
    for c in a.split(" ") {
        if let Ok(n) = c.parse::<u32>() {
            if !prev.is_none() && prev.unwrap() >= n {
                return false;
            }
            prev = Some(n);
        }
    }
    true
}
