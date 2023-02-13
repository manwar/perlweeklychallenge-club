// [dependencies]
// itertools = "0.10.5"

use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(specialquads(vec![1, 2, 3, 6]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(specialquads(vec![1, 1, 1, 3, 5]), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(specialquads(vec![3, 3, 6, 4, 5]), 0);
}

fn specialquads(a: Vec<usize>) -> usize {
    let mut ct = 0;
    for b in a.iter().combinations(4) {
        if b[0] + b[1] + b[2] == *b[3] {
            ct += 1;
        }
    }
    ct
}
