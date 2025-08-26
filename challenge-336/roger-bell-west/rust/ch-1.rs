use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(equalgroup(vec![1, 1, 2, 2, 2, 2]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(equalgroup(vec![1, 1, 1, 2, 2, 2, 3, 3]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(equalgroup(vec![5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7]), true);
}

#[test]
fn test_ex4() {
    assert_eq!(equalgroup(vec![1, 2, 3, 4]), false);
}

#[test]
fn test_ex5() {
    assert_eq!(equalgroup(vec![8, 8, 9, 9, 10, 10, 11, 11]), true);
}

fn equalgroup(a: Vec<i32>) -> bool {
    let s = a.iter().collect::<Counter<_>>();
    let mut v = s.values().collect::<Vec<_>>();
    v.sort();
    v.dedup();
    let l = *v[0];
    if l < 2 {
        return false;
    }
    for t in 2..=l {
        if v.iter().all(|c| *c % t == 0) {
            return true;
        }
    }
    false
}
