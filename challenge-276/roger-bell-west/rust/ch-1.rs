use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(completeday(vec![12, 12, 30, 24, 24]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(completeday(vec![72, 48, 24, 5]), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(completeday(vec![12, 18, 24]), 0);
}

fn completeday(a: Vec<u32>) -> usize {
    a.iter().combinations(2).filter(|c| (c[0] + c[1]) % 24 == 0).count()
}
