#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::BTreeMap;

#[test]
fn test_ex1() {
    assert_eq!(greatestenglishletter("PeRlwEeKLy"), "L");
}

#[test]
fn test_ex2() {
    assert_eq!(greatestenglishletter("ChaLlenge"), "L");
}

#[test]
fn test_ex3() {
    assert_eq!(greatestenglishletter("The"), "");
}

fn greatestenglishletter(a: &str) -> String {
    let mut m: BTreeMap<char, u32> = BTreeMap::new();
    for c in a.chars() {
        let uc = c.to_ascii_uppercase();
        let flag = if c.is_uppercase() { 1 } else { 2 };
        let fv = m.entry(uc).or_insert(0);
        *fv |= flag;
    }
    m.retain(|_, v| *v == 3);
    if m.len() > 0 {
        m.keys().last().unwrap().to_string()
    } else {
        "".to_string()
    }
}
