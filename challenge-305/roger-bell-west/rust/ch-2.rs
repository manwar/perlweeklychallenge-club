#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(aliendictionary(vec!["perl", "python", "raku"], vec!['h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k', 'm', 'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z']), vec!["raku", "python", "perl"]);
}

#[test]
fn test_ex2() {
    assert_eq!(aliendictionary(vec!["the", "weekly", "challenge"], vec!['c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z']), vec!["challenge", "the", "weekly"]);
}

fn aliendictionary(a: Vec<&str>, dc: Vec<char>) -> Vec<String> {
    let mxl = a.iter().map(|x| x.len()).max().unwrap();
    let mut dh: HashMap<char, usize> = HashMap::new();
    for (i, c) in dc.iter().enumerate() {
        dh.insert(*c, i + 1);
    }
    let mut b = a.into_iter().map(|x| x.to_string()).collect::<Vec<String>>();
    let mut numerics: HashMap<String, u64> = HashMap::new();
    for w in &b {
        let mut n = 0;
        let cc = w.chars().collect::<Vec<char>>();
        for i in 0 .. mxl {
            n *= 27;
            if i < w.len() {
                n += *dh.get(&cc[i]).unwrap() as u64;
            }
        }
        numerics.insert(w.clone(), n);
    }
    b.sort_by(|i, j| numerics.get(i).unwrap().cmp(&numerics.get(j).unwrap()));
    b
}
