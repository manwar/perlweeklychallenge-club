use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(uniquesum(vec![2, 1, 3, 2]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(uniquesum(vec![1, 1, 1, 1]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(uniquesum(vec![2, 1, 3, 4]), 10);
}

fn uniquesum(a: Vec<u32>) -> u32 {
    let c = a.into_iter().collect::<Counter<u32>>();
    c.iter().filter(|(_k, v)| **v == 1usize).map(|(k, _v)| k).sum()
}
