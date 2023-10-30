use counter::Counter;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(similarwords(vec!["aba", "aabb", "abcd", "bac", "aabc"]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(similarwords(vec!["aabb", "ab", "ba"]), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(similarwords(vec!["nba", "cba", "dba"]), 0);
}

fn similarwords(a: Vec<&str>) -> u32 {
    let mut ct: Counter<u32> = Counter::new();
    let ac = 'a' as u32;
    for w in a.iter() {
        let hs = w.chars().collect::<HashSet<char>>();
        let mut mask: u32 = 0;
        for c in hs {
            mask |= 1 << (c as u32 - ac);
        }
        ct[&mask] += 1;
    }
    let mut pairs = 0;
    for cv in ct.values() {
        if *cv > 1 {
            pairs += cv * (cv - 1) / 2;
        }
    }
    pairs as u32
}
