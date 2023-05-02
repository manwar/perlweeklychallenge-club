#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(rankscore(vec![1, 2, 4, 3, 5]), vec!["5", "4", "S", "B", "G"]);
}

#[test]
fn test_ex2() {
    assert_eq!(rankscore(vec![8, 5, 6, 7, 4]), vec!["G", "4", "B", "S", "5"]);
}

#[test]
fn test_ex3() {
    assert_eq!(rankscore(vec![3, 5, 4, 2]), vec!["B", "G", "S", "4"]);
}

#[test]
fn test_ex4() {
    assert_eq!(
        rankscore(vec![2, 5, 2, 1, 7, 5, 1]),
        vec!["4=", "S=", "4=", "6=", "G", "S=", "6="]
    );
}

fn rankscore(a: Vec<u32>) -> Vec<String> {
    let mut av: HashMap<u32, usize> = HashMap::new();
    for s in &a {
        av.entry(*s).and_modify(|k| *k += 1).or_insert(1);
    }
    let mut kk = av.keys().collect::<Vec<_>>();
    kk.sort_unstable();
    kk.reverse();
    let mut rank = 1;
    let mut tab: HashMap<u32, String> = HashMap::new();
    for k in kk {
        let siz = av.get(k).unwrap();
        let mut r: String;
        if rank <= 3 {
            r = ["G", "S", "B"][rank - 1].to_string();
        } else {
            r = rank.to_string();
        };
        if *siz > 1 {
            r.push('=');
        }
        tab.insert(*k, r.to_string());
        rank += siz;
    }
    a.iter().map(|i| tab.get(i).unwrap().to_string()).collect::<Vec<String>>()
}
