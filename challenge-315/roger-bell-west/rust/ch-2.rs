#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        findthird(
            "Perl is a my favourite language but Python is my favourite too.",
            "my",
            "favourite"
        ),
        vec!["language", "too"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        findthird(
            "Barbie is a beautiful doll also also a beautiful princess.",
            "a",
            "beautiful"
        ),
        vec!["doll", "princess"]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        findthird("we will we will rock you rock you.", "we", "will"),
        vec!["we", "rock"]
    );
}

fn findthird(s: &str, a: &str, b: &str) -> Vec<String> {
    let mut ss: Vec<String> = Vec::new();
    let mut sa = String::new();
    for c in s.chars() {
        match c {
            'A'..='Z' | 'a'..='z' => {
                sa.push(c);
            }
            _ => {
                if sa.len() > 0 {
                    ss.push(sa.clone());
                    sa = String::new();
                }
            }
        };
    }
    if sa.len() > 0 {
        ss.push(sa);
    }
    let mut out: Vec<String> = Vec::new();
    for p in ss.windows(3) {
        if p[0] == a && p[1] == b {
            out.push(p[2].clone());
        }
    }
    out
}
