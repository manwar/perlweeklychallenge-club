use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(similardominoes(vec![vec![1, 3], vec![3, 1], vec![2, 4], vec![6, 8]]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(similardominoes(vec![vec![1, 2], vec![2, 1], vec![1, 1], vec![1, 2], vec![2, 2]]), 3);
}

fn dvalue(a: Vec<u32>) -> u32 {
    if a[0] < a[1] {
        a[0] * 64 + a[1]
    } else {
        a[0] + a[1] * 64
    }
}

fn similardominoes(a: Vec<Vec<u32>>) -> usize {
    let c = a.into_iter().map(|x| dvalue(x)).collect::<Counter<_>>();
    let mut t = 0;
    for v in c.values() {
        if *v > 1 {
            t += *v;
        }
    }
    t
}
