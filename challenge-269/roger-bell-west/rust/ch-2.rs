#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(distributeelements(vec![2, 1, 3, 4, 5]), vec![2, 3, 4, 5, 1]);
}

#[test]
fn test_ex2() {
    assert_eq!(distributeelements(vec![3, 2, 4]), vec![3, 4, 2]);
}

#[test]
fn test_ex3() {
    assert_eq!(distributeelements(vec![5, 4, 3, 8]), vec![5, 3, 4, 8]);
}

fn distributeelements(a: Vec<u32>) -> Vec<u32> {
    let mut x = vec![a[0]];
    let mut y = vec![a[1]];
    for n in a.into_iter().skip(2) {
        if x.last().unwrap() > y.last().unwrap() {
            x.push(n);
        } else {
            y.push(n);
        }
    }
    x.append(&mut y);
    x
}
