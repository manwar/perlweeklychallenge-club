use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(oddletters("weekly"), false);
}

#[test]
fn test_ex2() {
    assert_eq!(oddletters("perl"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(oddletters("challenge"), false);
}

fn oddletters(a: &str) -> bool {
    let c = a.chars().collect::<Counter<_>>();
    c.values().all(|v| v % 2 == 1)
}
