// [dependencies]
// itertools = "0.10.5"

use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(divisiblepairs(vec![4, 5, 1, 6], 2), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(divisiblepairs(vec![1, 2, 3, 4], 2), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(divisiblepairs(vec![1, 3, 4, 5], 3), 2);
}

#[test]
fn test_ex4() {
    assert_eq!(divisiblepairs(vec![5, 1, 2, 3], 4), 2);
}

#[test]
fn test_ex5() {
    assert_eq!(divisiblepairs(vec![7, 2, 4, 5], 4), 1);
}

fn divisiblepairs(a: Vec<usize>, k: usize) -> usize {
    let mut ct = 0;
    for b in a.iter().combinations(2) {
        if (b[0] + b[1]) % k == 0 {
            ct += 1;
        }
    }
    ct
}
