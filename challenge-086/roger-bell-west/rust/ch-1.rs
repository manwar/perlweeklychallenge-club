#[test]
fn test_ex1() {
    assert_eq!(pti(vec![10, 8, 12, 15, 5],7),1);
}

#[test]
fn test_ex2() {
    assert_eq!(pti(vec![1, 5, 2, 9, 7],6),1);
}

#[test]
fn test_ex3() {
    assert_eq!(pti(vec![10, 30, 20, 50, 40],15),0);
}

use std::collections::HashMap;

fn pti(n: Vec<i32>, a: i32) -> i8 {
    let mut tab=HashMap::new();
    for x in n.clone() {
        tab.insert(x,1);
    }
    for x in n {
        if tab.contains_key(&(x+a)) {
            return 1
        }
    }
    return 0;
}
