#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(stringliedetector("aa - two vowels and zero consonants"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(stringliedetector("iv - one vowel and one consonant"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(
        stringliedetector("hello - three vowels and two consonants"),
        false
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        stringliedetector("aeiou - five vowels and zero consonants"),
        true
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        stringliedetector("aei - three vowels and zero consonants"),
        true
    );
}

fn stringliedetector(a: &str) -> bool {
    let words = a.split(' ').collect::<Vec<_>>();
    let mut vowels = 0;
    let mut consonants = 0;
    for c in words[0].chars() {
        match c {
            'a' | 'e' | 'i' | 'o' | 'u' => {
                vowels += 1;
            }
            _ => {
                consonants += 1;
            }
        };
    }
    let w2n = HashMap::from([
        ("zero", 0),
        ("one", 1),
        ("two", 2),
        ("three", 3),
        ("four", 4),
        ("five", 5),
        ("six", 6),
        ("seven", 7),
        ("eight", 8),
        ("nine", 9),
        ("ten", 10),
    ]);
    let mut valid = true;
    let mut mc = 0;
    for w in &words[2..] {
        if w2n.contains_key(w) {
            mc = w2n[w];
        } else {
            match *w {
                "vowels" | "vowel" => {
                    if mc != vowels {
                        valid = false;
                    }
                }
                "consonants" | "consonant" => {
                    if mc != consonants {
                        valid = false;
                    }
                }
                _ => {}
            };
        }
        if !valid {
            break;
        }
    }
    valid
}
