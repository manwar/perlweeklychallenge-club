#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(textjustifier("Hi", 5), "*Hi**");
}

#[test]
fn test_ex2() {
    assert_eq!(textjustifier("Code", 10), "***Code***");
}

#[test]
fn test_ex3() {
    assert_eq!(textjustifier("Hello", 9), "**Hello**");
}

#[test]
fn test_ex4() {
    assert_eq!(textjustifier("Perl", 4), "Perl");
}

#[test]
fn test_ex5() {
    assert_eq!(textjustifier("A", 7), "***A***");
}

#[test]
fn test_ex6() {
    assert_eq!(textjustifier("", 5), "*****");
}

fn textjustifier(intxt: &str, width: usize) -> String {
    let mut working = vec!['*'; width];
    let offset = (width - intxt.len()) / 2;
    for (i, c) in intxt.chars().enumerate() {
        working[i + offset] = c;
    }
    working.iter().collect::<_>()
}
