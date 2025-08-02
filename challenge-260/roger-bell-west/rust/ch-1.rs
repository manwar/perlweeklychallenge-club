use counter::Counter;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(uniqueoccurrences(vec![1, 2, 2, 1, 1, 3]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(uniqueoccurrences(vec![1, 2, 3]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(uniqueoccurrences(vec![-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]), 1);
}

fn uniqueoccurrences(a: Vec<i32>) -> u32 {
    let c = a.into_iter().collect::<Counter<_>>();
    if c.len() == c.values().collect::<HashSet<_>>().len() {
        return 1;
    } else {
        return 0;
    }
}
