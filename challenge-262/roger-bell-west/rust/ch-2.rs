use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(countequaldivisible(vec![3, 1, 2, 2, 2, 1, 3], 2), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(countequaldivisible(vec![1, 2, 3], 1), 0);
}

fn countequaldivisible(a: Vec<u32>, k: usize) -> u32 {
    let mut s = 0;
    for c in a.iter().enumerate().combinations(2) {
        if c[0].1 == c[1].1 && c[0].0 * c[1].0 % k == 0 {
            s += 1;
        }
    }
    s
}
