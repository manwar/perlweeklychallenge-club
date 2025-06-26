use permutator::Combination;

#[test]
fn test_ex1() {
    assert_eq!(mad(vec![4, 1, 2, 3]), vec![vec![1, 2], vec![2, 3], vec![3, 4]]);
}

#[test]
fn test_ex2() {
    assert_eq!(mad(vec![1, 3, 7, 11, 15]), vec![vec![1, 3]]);
}

#[test]
fn test_ex3() {
    assert_eq!(mad(vec![1, 5, 3, 8]), vec![vec![1, 3], vec![3, 5]]);
}

fn mad(a: Vec<i32>) -> Vec<Vec<i32>> {
    let mut combs: Vec<Vec<i32>> = Vec::new();
    a.combination(2).for_each(|l| {
        let mut m = l.clone();
        m.sort();
        combs.push(vec![*m[0], *m[1]]);
    });
    let dif = combs.iter().map(|x| x[1] - x[0]).min().unwrap();
    let mut res = combs
        .iter()
        .cloned()
        .filter(|x| x[1] - x[0] == dif)
        .collect::<Vec<Vec<i32>>>();
    res.sort_unstable();
    res
}
