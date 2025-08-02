use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(digitcountvalue(vec![1, 2, 1, 0]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(digitcountvalue(vec![0, 3, 0]), false);
}

fn digitcountvalue(a: Vec<usize>) -> bool {
    let c = a.clone().into_iter().collect::<Counter<_>>();
    for ix in 0..a.len() {
        if a[ix] != c[&ix] {
            return false;
        }
    }
    true
}
