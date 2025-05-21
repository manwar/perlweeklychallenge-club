#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(formatstring("ABC-D-E-F", 3), "ABC-DEF");
}

#[test]
fn test_ex2() {
    assert_eq!(formatstring("A-BC-D-E", 2), "A-BC-DE");
}

#[test]
fn test_ex3() {
    assert_eq!(formatstring("-A-B-CD-E", 4), "A-BCDE");
}

fn formatstring(a: &str, n: usize) -> String {
    let p = a.chars().filter(|x| *x != '-').collect::<Vec<char>>();
    let mut r = p.len() % n;
    if r == 0 {
        r += n;
    }
    let mut o = String::new();
    for (i, c) in p.into_iter().enumerate() {
        if r == i {
            o.push('-');
            r += n;
        }
        o.push(c);
    }
    o
}
