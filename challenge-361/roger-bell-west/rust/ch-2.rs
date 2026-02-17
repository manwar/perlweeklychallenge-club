#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        findcelebrity(vec![
            vec![0, 0, 0, 0, 1, 0],
            vec![0, 0, 0, 0, 1, 0],
            vec![0, 0, 0, 0, 1, 0],
            vec![0, 0, 0, 0, 1, 0],
            vec![0, 0, 0, 0, 0, 0],
            vec![0, 0, 0, 0, 1, 0]
        ]),
        4
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        findcelebrity(vec![
            vec![0, 1, 0, 0],
            vec![0, 0, 1, 0],
            vec![0, 0, 0, 1],
            vec![1, 0, 0, 0]
        ]),
        -1
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        findcelebrity(vec![
            vec![0, 0, 0, 0, 0],
            vec![1, 0, 0, 0, 0],
            vec![1, 0, 0, 0, 0],
            vec![1, 0, 0, 0, 0],
            vec![1, 0, 0, 0, 0]
        ]),
        0
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        findcelebrity(vec![
            vec![0, 1, 0, 1, 0, 1],
            vec![1, 0, 1, 1, 0, 0],
            vec![0, 0, 0, 1, 1, 0],
            vec![0, 0, 0, 0, 0, 0],
            vec![0, 1, 0, 1, 0, 0],
            vec![1, 0, 1, 1, 0, 0]
        ]),
        3
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        findcelebrity(vec![
            vec![0, 1, 1, 0],
            vec![1, 0, 1, 0],
            vec![0, 0, 0, 0],
            vec![0, 0, 0, 0]
        ]),
        -1
    );
}

#[test]
fn test_ex6() {
    assert_eq!(
        findcelebrity(vec![
            vec![0, 0, 1, 1],
            vec![1, 0, 0, 0],
            vec![1, 1, 0, 1],
            vec![1, 1, 0, 0]
        ]),
        -1
    );
}

fn findcelebrity(a: Vec<Vec<u8>>) -> isize {
    let mut knowsnobody = HashSet::new();
    let mut everybodyknows = HashSet::new();
    for i in 0..a.len() {
        if a.iter()
            .map(|x| x[i])
            .enumerate()
            .filter(|(j, _)| *j != i)
            .all(|(_, y)| y == 1)
        {
            everybodyknows.insert(i);
        }
        if a[i].iter()
            .enumerate()
            .filter(|(j, _)| *j != i)
            .all(|(_, y)| *y == 0) {
                knowsnobody.insert(i);
            }
    }
    let celebs =
        knowsnobody.intersection(&everybodyknows).collect::<HashSet<_>>();
    if celebs.len() != 1 {
        return -1;
    }
    *celebs.into_iter().collect::<Vec<_>>()[0] as isize
}
