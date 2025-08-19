#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(
        findwinner(vec![
            vec![0, 0],
            vec![2, 0],
            vec![1, 1],
            vec![2, 1],
            vec![2, 2]
        ]),
        "A"
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        findwinner(vec![
            vec![0, 0],
            vec![1, 1],
            vec![0, 1],
            vec![0, 2],
            vec![1, 0],
            vec![2, 0]
        ]),
        "B"
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        findwinner(vec![
            vec![0, 0],
            vec![1, 1],
            vec![2, 0],
            vec![1, 0],
            vec![1, 2],
            vec![2, 1],
            vec![0, 1],
            vec![0, 2],
            vec![2, 2]
        ]),
        "Draw"
    );
}

#[test]
fn test_ex4() {
    assert_eq!(findwinner(vec![vec![0, 0], vec![1, 1]]), "Pending");
}

#[test]
fn test_ex5() {
    assert_eq!(
        findwinner(vec![
            vec![1, 1],
            vec![0, 0],
            vec![2, 2],
            vec![0, 1],
            vec![1, 0],
            vec![0, 2]
        ]),
        "B"
    );
}

fn findwinner(a: Vec<Vec<usize>>) -> String {
    let mut board = vec![vec![0; 3]; 3];
    let mut player: u8 = 1;
    for play in &a {
        board[play[0]][play[1]] = player;
        player = 3 - player;
    }
    for pattern in [
        [0isize, 0isize, 1isize, 0isize],
        [0, 1, 1, 0],
        [0, 2, 1, 0],
        [0, 0, 0, 1],
        [1, 0, 0, 1],
        [2, 0, 0, 1],
        [0, 0, 1, 1],
        [0, 2, 1, -1],
    ] {
        let mut cellvals = HashSet::new();
        for i in 0..3 {
            let x = (pattern[0] + i * pattern[2]) as usize;
            let y = (pattern[1] + i * pattern[3]) as usize;
            cellvals.insert(board[y][x]);
        }
        if cellvals.len() == 1 {
            // all the same cell value
            let winner = *cellvals.iter().nth(0).unwrap();
            if winner == 1 {
                return "A".to_string();
            } else if winner == 2 {
                return "B".to_string();
            }
        }
    }
    if a.len() == 9 {
        return "Draw".to_string();
    } else {
        return "Pending".to_string();
    }
}
