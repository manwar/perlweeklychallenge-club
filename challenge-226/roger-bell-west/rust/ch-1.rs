#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        shufflestring("lacelengh", vec![3, 2, 0, 5, 4, 8, 6, 7, 1]),
        "challenge"
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        shufflestring("rulepark", vec![4, 7, 3, 1, 0, 5, 2, 6]),
        "perlraku"
    );
}

fn shufflestring(st: &str, mp: Vec<usize>) -> String {
    let q = st.chars().collect::<Vec<char>>();
    let mut r = vec![' '; q.len()];
    for (i, ix) in mp.iter().enumerate() {
        r[*ix] = q[i];
    }
    r.iter().collect::<String>()
}
