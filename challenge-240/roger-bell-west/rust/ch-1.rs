#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(acronym(vec!["Perl", "Python", "Pascal"], "ppp"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(acronym(vec!["Perl", "Raku"], "rp"), false);
}

#[test]
fn test_ex3() {
    assert_eq!(acronym(vec!["Oracle", "Awk", "C"], "oac"), true);
}

fn acronym(strs: Vec<&str>, chk: &str) -> bool {
    strs.iter()
        .map(|x| x.chars().next().unwrap())
        .collect::<String>()
        .to_ascii_lowercase()
        == chk.to_ascii_lowercase()
}
