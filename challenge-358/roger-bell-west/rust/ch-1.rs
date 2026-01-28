#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maxstrvalue(vec!["123", "45", "6"]), 123);
}

#[test]
fn test_ex2() {
    assert_eq!(maxstrvalue(vec!["abc", "de", "fghi"]), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(maxstrvalue(vec!["0012", "99", "a1b2c"]), 99);
}

#[test]
fn test_ex4() {
    assert_eq!(maxstrvalue(vec!["x", "10", "xyz", "007"]), 10);
}

#[test]
fn test_ex5() {
    assert_eq!(maxstrvalue(vec!["hello123", "2026", "perl"]), 2026);
}

fn strvalue(a: &str) -> u32 {
    if let Ok(x) = a.parse::<u32>() {
        return x;
    }
    a.len() as u32
}

fn maxstrvalue(a: Vec<&str>) -> u32 {
    a.into_iter().map(|x| strvalue(x)).max().unwrap()
}
