#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(
        pythagoreanmeans(vec![1, 3, 5, 7, 9]),
        HashMap::from([("AM", 5.0), ("GM", 3.9), ("HM", 2.8),])
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        pythagoreanmeans(vec![2, 4, 6, 8, 10]),
        HashMap::from([("AM", 6.0), ("GM", 5.2), ("HM", 4.4),])
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        pythagoreanmeans(vec![1, 2, 3, 4, 5]),
        HashMap::from([("AM", 3.0), ("GM", 2.6), ("HM", 2.2),])
    );
}

fn pythagoreanmeans(s: Vec<u32>) -> HashMap<&'static str, f64> {
    return HashMap::from([
        ("AM", round1(arithmeticmean(&s))),
        ("GM", round1(geometricmean(&s))),
        ("HM", round1(harmonicmean(&s))),
    ]);
}

fn round1(x: f64) -> f64 {
    (10. * x).round() / 10.0
}

fn arithmeticmean(s: &Vec<u32>) -> f64 {
    (s.iter().fold(0, |acc, x| acc + *x) as f64) / (s.len() as f64)
}

fn geometricmean(s: &Vec<u32>) -> f64 {
    (s.iter().fold(1, |acc, x| acc * *x) as f64).powf(1. / (s.len() as f64))
}

fn harmonicmean(s: &Vec<u32>) -> f64 {
    (s.len() as f64) / (s.iter().fold(0., |acc, x| acc + 1. / (*x as f64)))
}
