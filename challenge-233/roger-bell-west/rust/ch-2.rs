use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(frequencysort(vec![1, 1, 2, 2, 2, 3]), vec![3, 1, 1, 2, 2, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(frequencysort(vec![2, 3, 1, 3, 2]), vec![1, 3, 3, 2, 2]);
}

#[test]
fn test_ex3() {
    assert_eq!(
        frequencysort(vec![-1, 1, -6, 4, 5, -6, 1, 4, 1]),
        vec![5, -1, 4, 4, -6, -6, 1, 1, 1]
    );
}

fn frequencysort(a: Vec<i32>) -> Vec<i32> {
    let mut ct = a.into_iter().collect::<Counter<i32>>().most_common_ordered();
    ct.reverse();
    let mut out = Vec::new();
    for (k, v) in ct.iter() {
        out.append(&mut vec![*k; *v]);
    }
    out
}
