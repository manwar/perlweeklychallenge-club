use counter::Counter;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        twoofthree(vec![vec![1, 1, 2, 4], vec![2, 4], vec![4]]),
        vec![2, 4]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        twoofthree(vec![vec![4, 1], vec![2, 4], vec![1, 2]]),
        vec![1, 2, 4]
    );
}

fn twoofthree(a: Vec<Vec<u32>>) -> Vec<u32> {
    let mut ct: Counter<u32> = Counter::new();
    for iv in a {
        ct.extend(iv.into_iter().collect::<HashSet<_>>());
    }
    let mut out = ct
        .iter()
        .filter(|(_k, v)| **v >= 2)
        .map(|(k, _v)| *k)
        .collect::<Vec<_>>();
    out.sort();
    out
}
