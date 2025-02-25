#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maximumaverage(vec![1, 12, -5, -6, 50, 3], 4), 12.75);
}

#[test]
fn test_ex2() {
    assert_eq!(maximumaverage(vec![5], 1), 5.0);
}

fn maximumaverage(a: Vec<i32>, n: usize) -> f64 {
    let mut mx = 0;
    for s in a.windows(n) {
        mx = std::cmp::max(mx, s.into_iter().sum());
    }
    mx as f64 / n as f64
}
