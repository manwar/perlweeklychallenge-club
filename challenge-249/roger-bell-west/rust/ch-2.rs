use itertools::Itertools;
use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(distringmatch("IDID"), vec![0, 4, 1, 3, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(distringmatch("III"), vec![0, 1, 2, 3]);
}

#[test]
fn test_ex3() {
    assert_eq!(distringmatch("DDI"), vec![3, 2, 0, 1]);
}

fn distringmatch(a: &str) -> Vec<u32> {
    let mut v = 1 << (a.len() - 1);
    let mut wv = v << 1;
    let mut out = vec![wv];
    for c in a.chars() {
        if c == 'I' {
            wv += v;
        } else {
            wv -= v;
        }
        v >>= 1;
        out.push(wv);
    }
    let c = out
        .iter()
        .sorted()
        .enumerate()
        .map(|(i, v)| (v, i))
        .collect::<HashMap<_, _>>();
    out.iter().map(|v| c[&v] as u32).collect::<Vec<_>>()
}
