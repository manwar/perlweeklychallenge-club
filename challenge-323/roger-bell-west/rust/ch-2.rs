#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        taxamount(10, vec![vec![3, 50], vec![7, 10], vec![12, 25]]),
        2.65
    );
}

#[test]
fn test_ex2() {
    assert_eq!(taxamount(2, vec![vec![1, 0], vec![4, 25], vec![5, 50]]), 0.25);
}

#[test]
fn test_ex3() {
    assert_eq!(taxamount(0, vec![vec![2, 50]]), 0.0);
}

fn taxamount(income: u32, brackets: Vec<Vec<u32>>) -> f64 {
    let mut tax = 0;
    let mut lastbracket = 0;
    for bracket in brackets {
        if income > lastbracket {
            tax +=
                (std::cmp::min(income, bracket[0]) - lastbracket) * bracket[1];
        } else {
            break;
        }
        lastbracket = bracket[0];
    }
    (tax as f64) / 100.0
}
