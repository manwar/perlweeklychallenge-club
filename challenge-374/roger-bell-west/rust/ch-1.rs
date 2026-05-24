#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(countvowel("aeiou"), vec!["aeiou"]);
}

#[test]
fn test_ex2() {
    assert_eq!(countvowel("aaeeeiioouu"), vec!["aeeeiioou"]);
}

#[test]
fn test_ex3() {
    assert_eq!(countvowel("aeiouuaxaeiou"), vec!["aeiou", "aeiou", "eiouua"]);
}

#[test]
fn test_ex4() {
    assert_eq!(countvowel("uaeiou"), vec!["aeiou", "uaeio"]);
}

#[test]
fn test_ex5() {
    assert_eq!(countvowel("aeioaeioa"), Vec::<String>::new());
}

fn countvowel(a0: &str) -> Vec<String> {
    let a = a0.chars().collect::<Vec<_>>();
    let mut found = Vec::new();
    let mut l = a.len();
    for start in (0..=l - 5).rev() {
        'END: for eend in start + 5..=l {
            let mut sample = a[start..eend].iter().collect::<HashSet<_>>();
            for c in ['a', 'e', 'i', 'o', 'u'] {
                if !sample.contains(&c) {
                    continue 'END;
                }
                sample.remove(&c);
            }
            if sample.len() == 0 {
                found.push(a[start..eend].iter().collect::<String>());
                l = eend - 1;
                break;
            }
        }
    }
    found.sort();
    found
}
