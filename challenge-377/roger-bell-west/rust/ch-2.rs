#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(prefixsuffix(vec!["a", "aba", "ababa", "aa"]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(prefixsuffix(vec!["pa", "papa", "ma", "mama"]), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(prefixsuffix(vec!["abao", "abab"]), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(prefixsuffix(vec!["abab", "abab"]), 1);
}

#[test]
fn test_ex5() {
    assert_eq!(prefixsuffix(vec!["ab", "abab", "ababab"]), 3);
}

fn prefixsuffix(a0: Vec<&str>) -> usize {
    let mut tot = 0;
    let mut a = a0.clone();
    a.sort_unstable_by_key(|x| x.len());
    for si in 0..a.len() - 1 {
        for li in si + 1..a.len() {
            if let Some(left) = a[li].find(a[si]) {
                if left == 0 {
                    if let Some(right) = a[li].rfind(a[si]) {
                        if right == a[li].len() - a[si].len() {
                            tot += 1;
                        }
                    }
                }
            }
        }
    }
    tot
}
