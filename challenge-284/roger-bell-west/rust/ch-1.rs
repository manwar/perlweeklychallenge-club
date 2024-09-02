use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(luckyinteger(vec![2, 2, 3, 4]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(luckyinteger(vec![1, 2, 2, 3, 3, 3]), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(luckyinteger(vec![1, 1, 1, 3]), -1);
}

fn luckyinteger(a: Vec<usize>) -> i32 {
    let c = a.into_iter().collect::<Counter<_>>();
    for pair in c.most_common_tiebreaker(|&a, &b| b.cmp(&a)) {
        if pair.0 == pair.1 {
            return pair.0 as i32;
        }
    }
    -1
}
