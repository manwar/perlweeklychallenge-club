#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(backspacecompare("ab#c", "ad#c"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(backspacecompare("ab##", "a#b#"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(backspacecompare("a#b", "c"), false);
}

fn backspacecompare(a: &str, b: &str) -> bool {
    let mut sa: Vec<String> = Vec::new();
    for i in [a, b] {
        let mut oa = Vec::new();
        for c in i.chars() {
            if c == '#' {
                oa.pop();
            } else {
                oa.push(c)
            }
        }
        sa.push(oa.iter().collect());
    }
    sa[0] == sa[1]
}
