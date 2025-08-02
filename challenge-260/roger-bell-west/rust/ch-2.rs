use itertools::Itertools;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(dictionaryrank("CAT"), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(dictionaryrank("GOOGLE"), 88);
}

#[test]
fn test_ex3() {
    assert_eq!(dictionaryrank("SECRET"), 255);
}

fn dictionaryrank(a: &str) -> usize {
    let c = a.chars().collect::<Vec<char>>();
    let mut d = HashSet::new();
    for o in c.iter().permutations(c.len()) {
        d.insert(o.iter().copied().collect::<String>());
    }
    let mut dd = d.iter().collect::<Vec<_>>();
    dd.sort();
    for (i, s) in dd.iter().enumerate() {
        if s == &a {
            return i + 1;
        }
    }
    0
}
