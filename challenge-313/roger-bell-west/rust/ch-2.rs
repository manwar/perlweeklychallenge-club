#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(reverseletters("p-er?l"), "l-re?p");
}

#[test]
fn test_ex2() {
    assert_eq!(reverseletters("wee-k!L-y"), "yLk-e!e-w");
}

#[test]
fn test_ex3() {
    assert_eq!(reverseletters("_c-!h_all-en!g_e"), "_e-!g_nel-la!h_c");
}

fn reverseletters(a: &str) -> String {
    let mut vout: Vec<char> = vec![' '; a.len()];
    let mut letterslots: Vec<usize> = Vec::new();
    let mut letters: Vec<char> = Vec::new();
    for (i, c) in a.chars().enumerate() {
        if c.is_alphabetic() {
            letterslots.push(i);
            letters.push(c);
        } else {
            vout[i] = c;
        }
    }
    for i in letterslots {
        vout[i] = letters.pop().unwrap();
    }
    vout.into_iter().collect::<String>()
}
