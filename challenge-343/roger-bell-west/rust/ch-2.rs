#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        championteam(vec![vec![0, 1, 1], vec![0, 0, 1], vec![0, 0, 0]]),
        0
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        championteam(vec![
            vec![0, 1, 0, 0],
            vec![0, 0, 0, 0],
            vec![1, 1, 0, 0],
            vec![1, 1, 1, 0]
        ]),
        3
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        championteam(vec![
            vec![0, 1, 0, 1],
            vec![0, 0, 1, 1],
            vec![1, 0, 0, 0],
            vec![0, 0, 1, 0]
        ]),
        0
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        championteam(vec![vec![0, 1, 1], vec![0, 0, 0], vec![0, 1, 0]]),
        0
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        championteam(vec![
            vec![0, 0, 0, 0, 0],
            vec![1, 0, 0, 0, 0],
            vec![1, 1, 0, 1, 1],
            vec![1, 1, 0, 0, 0],
            vec![1, 1, 0, 1, 0]
        ]),
        2
    );
}

fn championteam(a: Vec<Vec<u8>>) -> usize {
    let mut maxw = 0;
    let mut teamw = Vec::new();
    for (i, w) in a.iter().enumerate() {
        let wins = w.iter().sum();
        if wins > maxw {
            teamw = Vec::new();
            maxw = wins
        }
        if wins == maxw {
            teamw.push(i);
        }
    }
    if teamw.len() == 1 {
        return teamw[0];
    }
    let mut bestt = teamw[0];
    for rt in teamw.iter().skip(1) {
        if a[*rt][bestt] == 1 {
            bestt = *rt;
        }
    }
    bestt
}
