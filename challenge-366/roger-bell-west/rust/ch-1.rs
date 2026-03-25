#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        countprefixes(vec!["a", "ap", "app", "apple", "banana"], "apple"),
        4
    );
}

#[test]
fn test_ex2() {
    assert_eq!(countprefixes(vec!["cat", "dog", "fish"], "bird"), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(
        countprefixes(vec!["hello", "he", "hell", "heaven", "he"], "hello"),
        4
    );
}

#[test]
fn test_ex4() {
    assert_eq!(countprefixes(vec!["", "code", "coding", "cod"], "coding"), 3);
}

#[test]
fn test_ex5() {
    assert_eq!(
        countprefixes(
            vec!["p", "pr", "pro", "prog", "progr", "progra", "program"],
            "program"
        ),
        7
    );
}

fn countprefixes(a: Vec<&str>, b: &str) -> usize {
    a.iter().filter(|x| b.starts_with(*x)).count()
}
