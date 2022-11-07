#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(decodedlist("11"), vec!["AA", "K"]);
}

#[test]
fn test_ex2() {
    assert_eq!(decodedlist("1115"), vec!["AAAE", "AAO", "AKE", "KAE", "KO"]);
}

#[test]
fn test_ex3() {
    assert_eq!(decodedlist("127"), vec!["ABG", "LG"]);
}

fn decodedlist(s: &str) -> Vec<String> {
    let mut stack = VecDeque::new();
    stack.push_back(vec![s.chars().collect::<Vec<char>>()]);
    let mut out = Vec::new();
    loop {
        let mut ent = stack.pop_front().unwrap();
        let tail = ent.pop().unwrap();
        if tail.len() == 0 {
            out.push(ent);
        } else {
            if tail[0] != '0' {
                let mut q = ent.clone();
                q.push(vec![tail[0]]);
                q.push(tail[1..].to_vec());
                stack.push_back(q);
            }
            if tail.len() >= 2 {
                let v = tail[0..=1]
                    .iter()
                    .collect::<String>()
                    .parse::<u8>()
                    .unwrap();
                if v >= 1 && v <= 26 {
                    let mut q = ent.clone();
                    q.push(tail[0..=1].to_vec());
                    q.push(tail[2..].to_vec());
                    stack.push_back(q);
                }
            }
        }
        if stack.len() == 0 {
            break;
        }
    }
    let mut k = Vec::new();
    let alphazero = ('A' as u8) - 1;
    for x in out {
        k.push(
            x.iter()
                .map(|i| {
                    (alphazero
                        + ((*i)
                            .iter()
                            .collect::<String>()
                            .parse::<u8>()
                            .unwrap())) as char
                })
                .collect::<String>(),
        );
    }
    k.sort();
    k
}
