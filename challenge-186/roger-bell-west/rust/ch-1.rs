#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        ziplist(vec!["1", "2", "3"], vec!["a", "b", "c"]),
        vec!["1", "a", "2", "b", "3", "c"]
    );
}

fn ziplist(a: Vec<&str>, b: Vec<&str>) -> Vec<String> {
    a.iter()
        .zip(b.iter())
        .map(|x| vec![x.0.to_string(), x.1.to_string()])
        .collect::<Vec<Vec<String>>>()
        .concat()
}
