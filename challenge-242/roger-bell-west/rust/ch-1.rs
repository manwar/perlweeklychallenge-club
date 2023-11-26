use itertools::Itertools;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        missingmembers(vec![1, 2, 3], vec![2, 4, 6]),
        vec![vec![1, 3], vec![4, 6]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        missingmembers(vec![1, 2, 3, 3], vec![1, 1, 2, 2]),
        vec![vec![3], Vec::<u32>::new()]
    );
}

fn halfmissing(a: &Vec<u32>, bh: HashSet<&u32>) -> Vec<u32> {
    a.iter()
        .filter(|n| !bh.contains(n))
        .unique()
        .map(|i| *i)
        .collect::<Vec<_>>()
}

fn missingmembers(a: Vec<u32>, b: Vec<u32>) -> Vec<Vec<u32>> {
    let ah = a.iter().collect::<HashSet<_>>();
    let bh = b.iter().collect::<HashSet<_>>();
    vec![halfmissing(&a, bh), halfmissing(&b, ah)]
}
