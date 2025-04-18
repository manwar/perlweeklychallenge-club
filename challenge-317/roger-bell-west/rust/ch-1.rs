#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(acronyms(vec!["Perl", "Weekly", "Challenge"], "PWC"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(acronyms(vec!["Bob", "Charlie", "Joe"], "BCJ"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(acronyms(vec!["Morning", "Good"], "MM"), false);
}

fn acronyms(a: Vec<&str>, b: &str) -> bool {
    let mut os = String::new();
    for c in a {
        os.push(c.chars().nth(0).unwrap());
    }
    os == b.to_string()
}
