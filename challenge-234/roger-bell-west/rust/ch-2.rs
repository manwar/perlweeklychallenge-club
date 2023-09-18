use counter::Counter;
use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(unequaltriplets(vec![4, 4, 2, 4, 3]), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(unequaltriplets(vec![1, 1, 1, 1, 1]), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(unequaltriplets(vec![4, 7, 1, 10, 7, 4, 1, 1]), 28);
}

fn unequaltriplets(utl: Vec<u32>) -> u32 {
    let utc = utl.iter().collect::<Counter<_>>();
    let kl = utc.keys().collect::<Vec<_>>();
    if kl.len() < 3 {
        return 0;
    }
    let mut out = 0;
    for c in kl.iter().combinations(3) {
        out += utc[**c[0]] * utc[**c[1]] * utc[**c[2]];
    }
    out as u32
}
