use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(uniquenumber(vec![3, 3, 1]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(uniquenumber(vec![3, 2, 4, 2, 4]), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(uniquenumber(vec![1]), 1);
}

#[test]
fn test_ex4() {
    assert_eq!(uniquenumber(vec![4, 3, 1, 1, 1, 4]), 3);
}

fn uniquenumber(a: Vec<i32>) -> i32 {
    let c = a.into_iter().collect::<Counter<_>>();
    for (k, v) in c.iter() {
        if *v == 1 {
            return *k;
        }
    }
    -1
}
