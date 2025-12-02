use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(goodsubstrings("abcaefg"), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(goodsubstrings("xyzzabc"), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(goodsubstrings("aababc"), 1);
}

#[test]
fn test_ex4() {
    assert_eq!(goodsubstrings("qwerty"), 4);
}

#[test]
fn test_ex5() {
    assert_eq!(goodsubstrings("zzzaaa"), 0);
}

fn goodsubstrings(a: &str) -> usize {
    let mut p = 0;
    for s in a.chars().collect::<Vec<_>>().windows(3) {
        let c = s.iter().collect::<Counter<_>>();
        if *c.values().max().unwrap() == 1 {
            p += 1;
        }
    }
    p
}
