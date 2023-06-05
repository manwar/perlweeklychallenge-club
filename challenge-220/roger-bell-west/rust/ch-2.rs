// [dependencies]
// itertools = "0.10.5"

use itertools::Itertools;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(squareful(vec![1, 17, 8]), vec![vec![1, 8, 17], vec![17, 8, 1]]);
}

#[test]
fn test_ex2() {
    assert_eq!(squareful(vec![2, 2, 2]), vec![vec![2, 2, 2]]);
}

fn squared(a: u32) -> u32 {
    a * a
}

fn squareful(lst: Vec<u32>) -> Vec<Vec<u32>> {
    let mut results: HashSet<Vec<u32>> = HashSet::new();
    let mut squares: HashSet<u32> = HashSet::new();
    for la in lst.iter().permutations(lst.len()) {
        let mut squareful = true;
        for a in la.windows(2) {
            let cs = a[0] + a[1];
            let mut mx = squared(squares.len() as u32);
            while cs > mx {
                mx = squared(squares.len() as u32 + 1);
                squares.insert(mx);
            }
            if !squares.contains(&cs) {
                squareful = false;
                break;
            }
        }
        if squareful {
            results.insert(la.into_iter().map(|i| *i).collect::<Vec<u32>>());
        }
    }
    let mut out = Vec::new();
    for a in results {
        out.push(a);
    }
    out.sort();
    out
}
