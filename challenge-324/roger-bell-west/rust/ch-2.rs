use permutator::Combination;

#[test]
fn test_ex1() {
    assert_eq!(totalxor(vec![1, 3]), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(totalxor(vec![5, 1, 6]), 28);
}

#[test]
fn test_ex3() {
    assert_eq!(totalxor(vec![3, 4, 5, 6, 7, 8]), 480);
}

fn totalxor(i: Vec<i64>) -> i64 {
    let mut tot = 0;
    for n in 1 ..= i.len() {
        i.combination(n).for_each(|l| {
            tot += l.into_iter().fold(0, |acc, x| acc ^ x)
        })
    }
    tot
}
