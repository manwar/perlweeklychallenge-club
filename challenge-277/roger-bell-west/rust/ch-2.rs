use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(strongpair(vec![1, 2, 3, 4, 5]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(strongpair(vec![5, 7, 1, 7]), 1);
}

fn strongpair(a0: Vec<i32>) -> usize {
    let mut a = a0.clone();
    a.sort();
    a.dedup();
    a.iter()
        .combinations(2)
        .filter(|c| {
            (c[0] - c[1]).abs() < **c.iter().min().unwrap()
        })
        .count()
}
