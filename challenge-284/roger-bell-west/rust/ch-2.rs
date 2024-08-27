use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(
        relativesort(
            vec![2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
            vec![2, 1, 4, 3, 5, 6]
        ),
        vec![2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        relativesort(vec![3, 3, 4, 6, 2, 4, 2, 1, 3], vec![1, 3, 2]),
        vec![1, 3, 3, 3, 2, 2, 4, 4, 6]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        relativesort(vec![3, 0, 5, 0, 2, 1, 4, 1, 1], vec![1, 0, 3, 2]),
        vec![1, 1, 1, 0, 0, 3, 2, 4, 5]
    );
}

fn relativesort(list1: Vec<u32>, list2: Vec<u32>) -> Vec<u32> {
    let mut c = list1.into_iter().collect::<Counter<_>>();
    let mut out = Vec::new();
    for i in list2 {
        out.append(&mut vec![i; c[&i]]);
        c.remove(&i);
    }
    let mut d = c.keys().collect::<Vec<_>>();
    d.sort();
    for i in d {
        out.append(&mut vec![*i; c[&i]]);
    }
    out
}
