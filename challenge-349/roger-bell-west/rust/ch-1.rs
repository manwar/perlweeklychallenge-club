#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(powerstring("textbook"), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(powerstring("aaaaa"), 5);
}

#[test]
fn test_ex3() {
    assert_eq!(powerstring("hoorayyy"), 3);
}

#[test]
fn test_ex4() {
    assert_eq!(powerstring("x"), 1);
}

#[test]
fn test_ex5() {
    assert_eq!(powerstring("aabcccddeeffffghijjk"), 4);
}

fn powerstring(a: &str) -> usize {
    let mut mx = 0;
    let mut prev = 'A';
    let mut cur = 0;
    for c in a.chars() {
        if cur > 0 && c == prev {
            cur += 1;
        } else {
            cur = 1;
            prev = c;
        }
        mx = std::cmp::max(mx, cur);
    }
    mx
}
