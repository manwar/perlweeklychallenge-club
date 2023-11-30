#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

fn sortlanguage(langs: Vec<&str>, popularities: Vec<u32>) -> Vec<String> {
    let mut ix = (0..langs.len()).collect::<Vec<usize>>();
    ix.sort_unstable_by_key(|n| popularities[*n]);
    ix.iter().map(|n| langs[*n].to_string()).collect::<Vec<String>>()
}

#[test]
fn test_ex1() {
    assert_eq!(
        sortlanguage(vec!["perl", "c", "python"], vec![2, 1, 3]),
        vec!["c", "perl", "python"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        sortlanguage(vec!["c++", "haskell", "java"], vec![1, 3, 2]),
        vec!["c++", "java", "haskell"]
    );
}
