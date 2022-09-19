use std::collections::HashSet;

// [dependencies]
// serde_json = "1.0"

#[test]
fn test_ex1() {
    assert_eq!(
        uniquearray(vec![vec![1, 2], vec![3, 4], vec![5, 6], vec![1, 2]]),
        vec![vec![1, 2], vec![3, 4], vec![5, 6]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        uniquearray(vec![vec![9, 1], vec![3, 7], vec![2, 5], vec![2, 5]]),
        vec![vec![9, 1], vec![3, 7], vec![2, 5]]
    );
}

fn uniquearray(n: Vec<Vec<usize>>) -> Vec<Vec<usize>> {
    let mut o: Vec<Vec<usize>> = Vec::new();
    let mut oh = HashSet::new();
    for i in n {
        let ti = serde_json::to_string(&i).unwrap();
        if !oh.contains(&ti) {
            o.push(i);
            oh.insert(ti);
        }
    }
    o
}
