#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        maxwords(vec!["Hello world", "This is a test", "Perl is great"]),
        4
    );
}

#[test]
fn test_ex2() {
    assert_eq!(maxwords(vec!["Single"]), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(
        maxwords(vec![
            "Short",
            "This sentence has six words in total",
            "A B C",
            "Just four words here"
        ]),
        7
    );
}

#[test]
fn test_ex4() {
    assert_eq!(maxwords(vec!["One", "Two parts", "Three part phrase", ""]), 3);
}

#[test]
fn test_ex5() {
    assert_eq!(
        maxwords(vec![
            "The quick brown fox jumps over the lazy dog",
            "A",
            "She sells seashells by the seashore",
            "To be or not to be that is the question"
        ]),
        10
    );
}

fn maxwords(a: Vec<&str>) -> usize {
    a.iter().map(|x| x.split(' ').count()).max().unwrap()
}
