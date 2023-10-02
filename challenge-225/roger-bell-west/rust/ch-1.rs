#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        maxwords(vec![
            "Perl and Raku belong to the same family.",
            "I love Perl.",
            "The Perl and Raku Conference."
        ]),
        8
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        maxwords(vec![
            "The Weekly Challenge.",
            "Python is the most popular guest language.",
            "Team PWC has over 300 members."
        ]),
        7
    );
}

fn maxwords(a: Vec<&str>) -> usize {
    a.iter().map(|x| x.matches(' ').collect::<Vec<&str>>().len()).max().unwrap()
        + 1
}
