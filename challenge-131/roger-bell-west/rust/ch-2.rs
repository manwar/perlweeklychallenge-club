#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(fp("\"\"[]()","\"I like (parens) and the Apple ][+\" they said."),vec!["\"([\"".to_string(),"\")]\"".to_string()]);
}

#[test]
fn test_ex2() {
    assert_eq!(fp("**//<>","/* This is a comment (in some languages) */ <could be a tag>"),vec!["/**/<".to_string(),"/**/>".to_string()]);
}

fn fp(delims: &str,sample: &str) -> Vec<String> {
    let mut d=[HashSet::new(),HashSet::new()];
    for ci in (*delims).char_indices() {
        d[ci.0%2].insert(ci.1);
    }
    let mut o=vec![vec![],vec![]];
    for s in (*sample).chars() {
        for x in 0..=1 {
            if d[x].contains(&s) {
                o[x].push(s);
            }
        }
    }
    return o.into_iter().map(|i| i.into_iter().collect::<String>()).collect::<Vec<String>>();
}
