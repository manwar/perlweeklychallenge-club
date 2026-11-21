#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        minimumgeneticmutation(
            "AACCGGTT",
            "AACCGGTA",
            vec!["AACCGCTA", "AAACGGTA"]
        ),
        -1
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        minimumgeneticmutation(
            "AACCGGTT",
            "AACCGGAA",
            vec!["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"]
        ),
        2
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        minimumgeneticmutation(
            "AAAAAAAA",
            "AAAAACCC",
            vec!["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]
        ),
        -1
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        minimumgeneticmutation(
            "GAAAAAAA",
            "GCCCCCCC",
            vec![
                "GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA",
                "GCCCCCCA", "GCCCCCCC"
            ]
        ),
        7
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        minimumgeneticmutation("AACCGGTT", "AACCGGTT", vec!["AACCGGTA"]),
        0
    );
}

use std::collections::{HashMap, HashSet, VecDeque};

fn s2v(a: &str) -> Vec<char> {
    a.chars().collect::<Vec<char>>()
}

fn minimumgeneticmutation(from0: &str, to0: &str, bank: Vec<&str>) -> i32 {
    if from0 == to0 {
        return 0;
    }
    let mut paths: HashMap<Vec<char>, Vec<Vec<char>>> = HashMap::new();
    let mut nodes = bank.iter().map(|x| s2v(x)).collect::<Vec<_>>();
    let from = s2v(from0);
    let to = s2v(to0);
    nodes.push(from.clone());
    for a in 0..nodes.len() - 2 {
        for b in a + 1..nodes.len() {
            let mut delta = 0;
            for c in 0..nodes[a].len() {
                if nodes[a][c] != nodes[b][c] {
                    delta += 1;
                    if delta > 1 {
                        break;
                    }
                }
            }
            if delta == 1 {
                let l = paths.entry(nodes[a].clone()).or_insert(Vec::new());
                l.push(nodes[b].clone());
                let m = paths.entry(nodes[b].clone()).or_insert(Vec::new());
                m.push(nodes[a].clone());
            }
        }
    }
    let mut seen = HashSet::new();
    let mut queue: VecDeque<(Vec<char>, usize)> = VecDeque::new();
    queue.push_back((from.clone(), 0));
    while let Some((gene, depth)) = queue.pop_front() {
        if gene == to {
            return depth as i32;
        }
        if let Some(e) = paths.get(&gene) {
            let mut sseen = seen.clone();
            let d = depth + 1;
            for g in e {
                if !seen.contains(g) {
                    queue.push_back((g.clone(), d));
                    sseen.insert(g.clone());
                }
            }
            seen = sseen;
        }
    }
    -1
}
