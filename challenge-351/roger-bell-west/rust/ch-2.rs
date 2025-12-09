#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(arithmeticprogression(vec![1.0, 3.0, 5.0, 7.0, 9.0]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(arithmeticprogression(vec![9.0, 1.0, 7.0, 5.0, 3.0]), true);
}

#[test]
fn test_ex3() {
    assert_eq!(arithmeticprogression(vec![1.0, 2.0, 4.0, 8.0, 16.0]), false);
}

#[test]
fn test_ex4() {
    assert_eq!(arithmeticprogression(vec![5.0, -1.0, 3.0, 1.0, -3.0]), true);
}

#[test]
fn test_ex5() {
    assert_eq!(arithmeticprogression(vec![1.5, 3.0, 0.0, 4.5, 6.0]), true);
}

fn arithmeticprogression(a0: Vec<f64>) -> bool {
    let epsilon = 0.0001;
    let mut a = a0.clone();
    a.sort_by(|a, b| a.partial_cmp(b).unwrap());
    let delta = a[1] - a[0];
    for v in a[1..].windows(2) {
        if (v[1] - v[0] - delta).abs() > epsilon {
            return false;
        }
    }
    true
}
