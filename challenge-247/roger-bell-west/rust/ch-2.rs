#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(mostfrequentletterpair("abcdbca"), "bc");
}

#[test]
fn test_ex2() {
    assert_eq!(mostfrequentletterpair("cdeabeabfcdfabgcd"), "ab");
}

fn mostfrequentletterpair(s0: &str) -> String {
    let mut f: HashMap<String, usize> = HashMap::new();
    let s = s0.chars().collect::<Vec<char>>();
    for i in 0..s.len() - 1 {
        let mut pair = String::new();
        pair.push(s[i]);
        pair.push(s[i + 1]);
        let en = f.entry(pair).or_insert(0);
        *en += 1;
    }
    let m = f.values().max().unwrap();
    let mut l = f.keys().filter(|i| f[*i] == *m).collect::<Vec<_>>();
    l.sort();
    l[0].to_string()
}
