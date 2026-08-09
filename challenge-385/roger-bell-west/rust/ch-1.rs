#[test]
fn test_ex1() {
    assert_eq!(uncommonwords("apple banana apple", "banana orange"), vec!["orange"]);
}

#[test]
fn test_ex2() {
    assert_eq!(uncommonwords("cat dog", "bird fish"), vec!["cat", "dog", "bird", "fish"]);
}

#[test]
fn test_ex3() {
    assert_eq!(uncommonwords("the quick brown fox", "the quick"), vec!["brown", "fox"]);
}

#[test]
fn test_ex4() {
    assert_eq!(uncommonwords("hello", "hello"), Vec::<String>::new());
}

#[test]
fn test_ex5() {
    assert_eq!(uncommonwords("blue blue red", "red green green yellow"), vec!["yellow"]);
}

use counter::Counter;

fn uncommonwords(a: &str, b: &str) -> Vec<String> {
    let mut c: Counter<&str> = Counter::new();
    for s in [a, b] {
        c += s.split_whitespace();
    }
    let mut out = Vec::new();
    for s in [a, b] {
        for w in s.split_whitespace() {
            if c[&w] == 1 {
                out.push(w.to_string());
            }
        }
    }
    out
}
