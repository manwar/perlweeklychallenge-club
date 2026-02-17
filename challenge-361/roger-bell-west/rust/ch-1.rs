#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(zeckendorfrepresentation(4), vec![3, 1]);
}

#[test]
fn test_ex2() {
    assert_eq!(zeckendorfrepresentation(12), vec![8, 3, 1]);
}

#[test]
fn test_ex3() {
    assert_eq!(zeckendorfrepresentation(20), vec![13, 5, 2]);
}

#[test]
fn test_ex4() {
    assert_eq!(zeckendorfrepresentation(96), vec![89, 5, 2]);
}

#[test]
fn test_ex5() {
    assert_eq!(zeckendorfrepresentation(100), vec![89, 8, 3]);
}

fn zeckendorfrepresentation(a: u32) -> Vec<u32> {
    let mut fib = vec![0, 1];
    while fib[fib.len() - 1] <= a {
        fib.push(fib[fib.len() - 1] + fib[fib.len() - 2]);
    }
    fib.pop();
    let mut res = Vec::new();
    let mut aw = a;
    while aw > 0 {
        let fl = fib.len() - 1;
        res.push(fib[fl]);
        aw -= fib[fl];
        fib.pop();
        fib.pop();
        while fib[fib.len() - 1] > aw {
            fib.pop();
        }
    }
    res
}
