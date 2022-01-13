#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(eertree("redivider"),vec!["r","redivider","e","edivide","d","divid","i","ivi","v"]);
}

#[test]
fn test_ex2() {
    assert_eq!(eertree("deific"),vec!["d","e","i","ifi","f","c"]);
}

#[test]
fn test_ex3() {
    assert_eq!(eertree("rotors"),vec!["r","rotor","o","oto","t","s"]);
}

#[test]
fn test_ex4() {
    assert_eq!(eertree("challenge"),vec!["c","h","a","l","ll","e","n","g"]);
}

#[test]
fn test_ex5() {
    assert_eq!(eertree("champion"),vec!["c","h","a","m","p","i","o","n"]);
}

#[test]
fn test_ex6() {
    assert_eq!(eertree("christmas"),vec!["c","h","r","i","s","t","m","a"]);
}

fn eertree(st: &str) -> Vec<String> {
    let c=st.chars().collect::<Vec<char>>();
    let mut pal: Vec<String>=Vec::new();
    for i in 0..c.len() {
        for j in i+1..=c.len() {
            let strpal=c[i..j].iter().map(|x| *x).collect::<Vec<char>>();
            let strrev=strpal.iter().map(|x| *x).rev().collect::<Vec<char>>();
            if strpal == strrev {
                pal.push(strpal.iter().map(|x| *x).collect::<String>());
            }
        }
    }
    println!("{:?}",pal);
    let mut out: Vec<String>=Vec::new();
    let mut f=HashSet::new();
    for i in pal {
        if !f.contains(&i) {
            f.insert(i.clone());
            out.push(i);
        }
    }
    out
}
