#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(greatercharacter(vec!['e', 'm', 'u', 'g'], 'b'), 'e');
}

#[test]
fn test_ex2() {
    assert_eq!(greatercharacter(vec!['d', 'c', 'e', 'f'], 'a'), 'c');
}

#[test]
fn test_ex3() {
    assert_eq!(greatercharacter(vec!['j', 'a', 'r'], 'o'), 'r');
}

#[test]
fn test_ex4() {
    assert_eq!(greatercharacter(vec!['d', 'c', 'a', 'f'], 'a'), 'c');
}

#[test]
fn test_ex5() {
    assert_eq!(greatercharacter(vec!['t', 'g', 'a', 'l'], 'v'), 'v');
}

fn greatercharacter(aa: Vec<char>, k: char) -> char {
    let mut a = aa.clone();
    a = a.iter().filter(|x| **x > k).map(|i| *i).collect::<Vec<char>>();
    if a.len() > 0 {
        a.sort();
        return a[0];
    } else {
        return k;
    }
}
