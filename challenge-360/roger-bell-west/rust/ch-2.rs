#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(wordsorter("The quick brown fox"), "brown fox quick The");
}

#[test]
fn test_ex2() {
    assert_eq!(
        wordsorter("Hello    World!   How   are you?"),
        "are Hello How World! you?"
    );
}

#[test]
fn test_ex3() {
    assert_eq!(wordsorter("Hello"), "Hello");
}

#[test]
fn test_ex4() {
    assert_eq!(
        wordsorter("Hello, World! How are you?"),
        "are Hello, How World! you?"
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        wordsorter("I have 2 apples and 3 bananas!"),
        "2 3 and apples bananas! have I"
    );
}

fn wordsorter(a: &str) -> String {
    let mut w = a.split(' ').filter(|x| *x != "").collect::<Vec<&str>>();
    w.sort_unstable_by_key(|x| x.to_lowercase());
    w.join(" ")
}
