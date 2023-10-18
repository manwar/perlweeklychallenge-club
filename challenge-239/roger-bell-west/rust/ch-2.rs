use itertools::Itertools;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        consistentstrings(vec!["ad", "bd", "aaab", "baa", "badab"], "ab"),
        2
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        consistentstrings(vec!["a", "b", "c", "ab", "ac", "bc", "abc"], "ab"),
        3
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        consistentstrings(
            vec!["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"],
            "cad"
        ),
        4
    );
}

fn consistentstrings(a: Vec<&str>, v: &str) -> u32 {
    let vs = v.chars().collect::<HashSet<char>>();
    a.iter().filter(|s| s.chars().unique().all(|c| vs.contains(&c))).count()
        as u32
}
