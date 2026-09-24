#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(wordslengthproduct(vec!["a", "ab", "abc", "d", "de", "def"]), 9);
}

#[test]
fn test_ex2() {
    assert_eq!(wordslengthproduct(vec!["a", "aa", "aaa", "aaaa"]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(wordslengthproduct(vec!["meet", "app", "code", "sky", "bold"]), 16);
}

#[test]
fn test_ex4() {
    assert_eq!(wordslengthproduct(vec!["a", "ab", "abc", "abcd", "efghi"]), 20);
}

#[test]
fn test_ex5() {
    assert_eq!(wordslengthproduct(vec!["xyz", "w", "abcdefg", "hij"]), 21);
}

use std::collections::HashSet;

fn wordslengthproduct(a: Vec<&str>) -> usize {
    let ws = a.iter().map(|x| x.chars().collect::<HashSet<_>>()).collect::<Vec<_>>();
    let mut mx = 0;
    for i in 0 .. ws.len() - 1 {
        for j in i + 1 .. ws.len() {
            if ws[i].intersection(&ws[j]).count() == 0 {
                mx = std::cmp::max(mx, a[i].len() * a[j].len());
            }
        }
    }
    mx
}
