#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maxdiff(vec![5, 9, 3, 4, 6]), 42);
}

#[test]
fn test_ex2() {
    assert_eq!(maxdiff(vec![1, -2, 3, -4]), 10);
}

#[test]
fn test_ex3() {
    assert_eq!(maxdiff(vec![-3, -1, -2, -4]), 10);
}

#[test]
fn test_ex4() {
    assert_eq!(maxdiff(vec![10, 2, 0, 5, 1]), 50);
}

#[test]
fn test_ex5() {
    assert_eq!(maxdiff(vec![7, 8, 9, 10, 10]), 44);
}

fn maxdiff(a: Vec<i32>) -> i32 {
    let mut md = 0;
    for w in 0..a.len() - 1 {
        for x in w + 1..a.len() {
            for y in w + 1..a.len() - 1 {
                if y != x {
                    for z in y + 1..a.len() {
                        if z != x {
                            let v = (a[w] * a[x] - a[y] * a[z]).abs();
                            md = *[md, v].iter().max().unwrap();
                        }
                    }
                }
            }
        }
    }
    md
}
