#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(finalscore(vec!["5", "2", "C", "D", "+"]), 30);
}

#[test]
fn test_ex2() {
    assert_eq!(finalscore(vec!["5", "-2", "4", "C", "D", "9", "+", "+"]), 27);
}

#[test]
fn test_ex3() {
    assert_eq!(finalscore(vec!["7", "D", "D", "C", "+", "3"]), 45);
}

#[test]
fn test_ex4() {
    assert_eq!(finalscore(vec!["-5", "-10", "+", "D", "C", "+"]), -55);
}

#[test]
fn test_ex5() {
    assert_eq!(
        finalscore(vec![
            "3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+"
        ]),
        128
    );
}

fn finalscore(a: Vec<&str>) -> i32 {
    let mut p: Vec<i32> = Vec::new();
    for n in a {
        match n {
            "C" => {
                let _ = p.pop();
            }
            "D" => p.push(2 * p[p.len() - 1]),
            "+" => p.push(p[p.len() - 2] + p[p.len() - 1]),
            _ => p.push(n.parse::<i32>().unwrap()),
        }
    }
    p.iter().sum()
}
