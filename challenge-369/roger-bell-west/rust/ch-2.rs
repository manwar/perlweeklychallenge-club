#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(groupdivision("RakuPerl", 4, "*"), vec!["Raku", "Perl"]);
}

#[test]
fn test_ex2() {
    assert_eq!(groupdivision("Python", 5, "0"), vec!["Pytho", "n0000"]);
}

#[test]
fn test_ex3() {
    assert_eq!(groupdivision("12345", 3, "x"), vec!["123", "45x"]);
}

#[test]
fn test_ex4() {
    assert_eq!(
        groupdivision("HelloWorld", 3, "_"),
        vec!["Hel", "loW", "orl", "d__"]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(groupdivision("AI", 5, "!"), vec!["AI!!!"]);
}

fn groupdivision(a0: &str, sz: usize, pad: &str) -> Vec<String> {
    let mut a = a0.to_string();
    while !a.len().is_multiple_of(sz) {
        a.push_str(pad);
    }
    let mut out = Vec::new();
    for i in (0..a.len()).step_by(sz) {
        out.push(a[i..(i + sz)].to_string());
    }
    out
}
