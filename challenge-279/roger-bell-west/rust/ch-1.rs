#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sortletters(vec!['R', 'E', 'P', 'L'], vec![3, 2, 1, 4]), "PERL");
}

#[test]
fn test_ex2() {
    assert_eq!(sortletters(vec!['A', 'U', 'R', 'K'], vec![2, 4, 1, 3]), "RAKU");
}

#[test]
fn test_ex3() {
    assert_eq!(
        sortletters(vec!['O', 'H', 'Y', 'N', 'P', 'T'], vec![5, 4, 2, 6, 1, 3]),
        "PYTHON"
    );
}

fn sortletters(a: Vec<char>, n: Vec<usize>) -> String {
    let mut out: Vec<char> = vec![' '; a.len()];
    for (i, l) in a.iter().enumerate() {
        out[n[i] - 1] = *l;
    }
    out.iter().collect::<String>()
}
