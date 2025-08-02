use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(
        mergeitems(
            vec![vec![1, 1], vec![2, 1], vec![3, 2]],
            vec![vec![2, 2], vec![1, 3]]
        ),
        vec![vec![1, 4], vec![2, 3], vec![3, 2]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        mergeitems(
            vec![vec![1, 2], vec![2, 3], vec![1, 3], vec![3, 2]],
            vec![vec![3, 1], vec![1, 3]]
        ),
        vec![vec![1, 8], vec![2, 3], vec![3, 3]]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        mergeitems(
            vec![vec![1, 1], vec![2, 2], vec![3, 3]],
            vec![vec![2, 3], vec![2, 4]]
        ),
        vec![vec![1, 1], vec![2, 9], vec![3, 3]]
    );
}

fn mergeitems(a: Vec<Vec<usize>>, b: Vec<Vec<usize>>) -> Vec<Vec<usize>> {
    let mut c: Counter<usize> = Counter::new();
    for v in [a, b] {
        for w in v {
            c[&w[0]] += w[1];
        }
    }
    let mut k = c.keys().collect::<Vec<_>>();
    k.sort();
    k.into_iter().map(|i| vec![*i, c[i]]).collect::<Vec<_>>()
}
