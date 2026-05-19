#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::iter;

#[test]
fn test_ex1() {
    assert_eq!(rearrangespaces("  challenge  "), "challenge    ");
}

#[test]
fn test_ex2() {
    assert_eq!(rearrangespaces("coding  is  fun"), "coding  is  fun");
}

#[test]
fn test_ex3() {
    assert_eq!(rearrangespaces("a b c  d"), "a b c d ");
}

#[test]
fn test_ex4() {
    assert_eq!(rearrangespaces("  team      pwc  "), "team          pwc");
}

#[test]
fn test_ex5() {
    assert_eq!(
        rearrangespaces("   the  weekly  challenge  "),
        "the    weekly    challenge "
    );
}

fn rearrangespaces(a: &str) -> String {
    let mut words = Vec::new();
    let mut spaces = 0;
    let mut ww = "".to_string();
    for c in a.chars() {
        if c.is_whitespace() {
            spaces += 1;
            if !ww.is_empty() {
                words.push(ww.clone());
                ww.clear();
            }
        } else {
            ww.push(c);
        }
    }
    if !ww.is_empty() {
        words.push(ww.clone());
    }
    let spdiv;
    let remainder;
    let divs = words.len() - 1;
    if divs > 0 {
        spdiv = spaces / divs;
        remainder = spaces % divs;
    } else {
        spdiv = 0;
        remainder = spaces;
    }
    let mut out =
        words.join(&iter::repeat(" ").take(spdiv).collect::<String>());
    if remainder > 0 {
        out.push_str(&iter::repeat(' ').take(remainder).collect::<String>());
    }
    out.to_string()
}
