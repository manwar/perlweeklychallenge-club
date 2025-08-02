use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(maximumfrequency(vec![1, 2, 2, 4, 1, 5]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(maximumfrequency(vec![1, 2, 3, 4, 5]), 5);
}

fn maximumfrequency(a: Vec<u32>) -> usize {
    let c = a.iter().collect::<Counter<_>>();
    let mx = c.most_common_ordered()[0].1;
    c.iter().filter(|(_k, v)| **v == mx).count() * mx
}
