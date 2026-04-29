use permutator::Combination;

#[test]
fn test_ex1() {
    assert_eq!(
        subsetequilibrium(vec![2, 1, 4, 3]),
        vec![vec![1, 4], vec![2, 1], vec![2, 3], vec![4, 3]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        subsetequilibrium(vec![3, 0, 3, 0]),
        vec![vec![3], vec![3, 0], vec![3, 0, 3]]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(subsetequilibrium(vec![5, 1, 1, 1]), vec![vec![5, 1, 1]]);
}

#[test]
fn test_ex4() {
    assert_eq!(
        subsetequilibrium(vec![3, -1, 4, 2]),
        vec![vec![3, -1, 4], vec![3, 2]]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(subsetequilibrium(vec![10, 20, 30, 40]), Vec::<Vec<i32>>::new());
}

fn subsetequilibrium(a: Vec<i32>) -> Vec<Vec<i32>> {
    let mut out = Vec::new();
    let b = a
        .iter()
        .enumerate()
        .map(|(i, x)| x - (i as i32) - 1)
        .collect::<Vec<i32>>();
    let ix = (0..b.len()).collect::<Vec<usize>>();
    for n in 1..b.len() {
        ix.combination(n).for_each(|iy| {
            let bp = iy.iter().map(|&&i| b[i]).collect::<Vec<_>>();
            if bp.iter().sum::<i32>() == 0 {
                let ap = iy.iter().map(|&&i| a[i]).collect::<Vec<_>>();
                out.push(ap);
            }
        });
    }
    out.sort();
    out
}
