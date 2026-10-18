#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(wordsquares(vec!["MA", "AM", "MY", "ME"]), vec!["MA", "AM"]);
}

#[test]
fn test_ex2() {
    assert_eq!(
        wordsquares(vec!["SUN", "USE", "NET", "SEE", "TEN"]),
        vec!["SUN", "USE", "NET"]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        wordsquares(vec!["BOAT", "TEAL", "AREA", "TSAR", "OGRE"]),
        vec!["BOAT", "OGRE", "AREA", "TEAL"]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        wordsquares(vec!["CARD", "AREA", "REAR", "DART"]),
        vec!["CARD", "AREA", "REAR", "DART"]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        wordsquares(vec!["HEART", "TREND", "EMBER", "RESIN", "ABUSE"]),
        vec!["HEART", "EMBER", "ABUSE", "RESIN", "TREND"]
    );
}

use std::collections::{HashSet, VecDeque};

fn wordsquares(a0: Vec<&str>) -> Vec<String> {
    let a =
        a0.iter().map(|x| x.chars().collect::<Vec<_>>()).collect::<Vec<_>>();
    let l = a[0].len();
    let words = a.clone().into_iter().collect::<HashSet<Vec<char>>>();
    let mut queue: VecDeque<Vec<Vec<char>>> = VecDeque::new();
    for w in a {
        queue.push_back(vec![w]);
    }
    while let Some(p) = queue.pop_front() {
        if p.len() == l {
            let mut results = Vec::new();
            for w in p {
                results.push(w.iter().collect::<String>());
            }
            return results;
        }
        for ca in
            words.difference(&p.clone().into_iter().collect::<HashSet<_>>())
        {
            let mut valid = true;
            for (i, c) in ca.iter().enumerate() {
                if i >= p.len() {
                    break;
                }
                if *c != p[i][p.len()] {
                    valid = false;
                    break;
                }
            }
            if valid {
                let mut pw = p.clone();
                pw.push(ca.to_vec());
                queue.push_back(pw);
            }
        }
    }
    Vec::new()
}
