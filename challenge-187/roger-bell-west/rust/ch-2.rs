// [dependencies]
// itertools = "0.10.5"

use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(magicaltriplets(vec![1, 2, 3, 2]), vec![3, 2, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(magicaltriplets(vec![1, 3, 2]), vec![]);
}

#[test]
fn test_ex3() {
    assert_eq!(magicaltriplets(vec![1, 1, 2, 3]), vec![]);
}

#[test]
fn test_ex4() {
    assert_eq!(magicaltriplets(vec![2, 4, 3]), vec![4, 3, 2]);
}

fn magicaltriplets(a: Vec<usize>) -> Vec<usize> {
    let mut out: Vec<usize> = Vec::new();
    let mut mv = 0;
    for b in a.iter().combinations(3) {
        if b[0] + b[1] > *b[2] && b[1] + b[2] > *b[0] && b[0] + b[2] > *b[1] {
            let v = b[0] + b[1] + b[2];
            if v > mv {
                mv = v;
                out = b.iter().map(|i| **i).collect::<Vec<usize>>();
            }
        }
    }
    out.sort();
    out.reverse();
    out
}
