use counter::Counter;

#[test]
fn test_ex1() {
    assert_eq!(popularword("Bob hit a ball, the hit BALL flew far after it was hit.", vec!["hit"]), "ball");
}

#[test]
fn test_ex2() {
    assert_eq!(popularword("Apple? apple! Apple, pear, orange, pear, apple, orange.", vec!["apple", "pear"]), "orange");
}

#[test]
fn test_ex3() {
    assert_eq!(popularword("A. a, a! A. B. b. b.", vec!["b"]), "a");
}

#[test]
fn test_ex4() {
    assert_eq!(popularword("Ball.ball,ball:apple!apple.banana", vec!["ball"]), "apple");
}

#[test]
fn test_ex5() {
    assert_eq!(popularword("The dog chased the cat, but the dog was faster than the cat.", vec!["the", "dog"]), "cat");
}

fn popularword(a: &str, banned: Vec<&str>) -> String {
    let b = a.to_lowercase();
    let mut words = b.split(|c: char| !c.is_alphabetic()).filter(|x| x.len() > 0).collect::<Counter<_>>();
    for p in banned {
        words.remove(&p);
    }
    words.most_common_ordered()[0].0.to_string()
}

