#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn find_winner(moves: &[[usize; 2]]) -> String {
    let mut board = [[' '; 3]; 3];
    for (i, &[r, c]) in moves.iter().enumerate() {
        board[r][c] = if i % 2 == 0 { 'A' } else { 'B' };
        let player = board[r][c];
        if (0..3).all(|j| board[r][j] == player)
            || (0..3).all(|j| board[j][c] == player)
            || (r == c && (0..3).all(|j| board[j][j] == player))
            || (r + c == 2 && (0..3).all(|j| board[j][2 - j] == player))
        {
            return player.to_string();
        }
    }
    if moves.len() == 9 {
        "Draw".to_string()
    } else {
        "Pending".to_string()
    }
}

#[test]
fn example() {
    assert_eq!(find_winner(&[[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]]), "A");
    assert_eq!(
        find_winner(&[[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]]),
        "B"
    );
    assert_eq!(
        find_winner(&[
            [0, 0],
            [1, 1],
            [2, 0],
            [1, 0],
            [1, 2],
            [2, 1],
            [0, 1],
            [0, 2],
            [2, 2]
        ]),
        "Draw"
    );
    assert_eq!(find_winner(&[[0, 0], [1, 1]]), "Pending");
    assert_eq!(
        find_winner(&[[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]]),
        "B"
    );
}
