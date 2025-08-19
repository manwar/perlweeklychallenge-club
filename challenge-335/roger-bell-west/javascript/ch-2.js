#! /usr/bin/node

"use strict"

function findwinner(a) {
    let board = [ [0, 0, 0], [0, 0, 0], [0, 0, 0] ];
    let player = 1;
    for (let play of a) {
        board[play[0]][play[1]] = player;
        player = 3 - player;
    }
    for (let pattern of [
        [0, 0, 1, 0],
        [0, 1, 1, 0],
        [0, 2, 1, 0],
        [0, 0, 0, 1],
        [1, 0, 0, 1],
        [2, 0, 0, 1],
        [0, 0, 1, 1],
        [0, 2, 1, -1]
    ]) {
        let cellvals = new Set;
        for (let i = 0; i <= 2; i++) {
            const x = pattern[0] + i * pattern[2];
            const y = pattern[1] + i * pattern[3];
            cellvals.add(board[y][x]);
        }
        if (cellvals.size == 1) {
            let winner = [...cellvals][0];
            if (winner == 1) {
                return "A";
            } else if (winner == 2) {
                return "B";
            }
        }
    }
    if (a.length == 9) {
        return "Draw";
    } else {
        return "Pending";
    }
}

if (findwinner([[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]]) == 'A') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (findwinner([[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]]) == 'B') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (findwinner([[0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1], [0, 2], [2, 2]]) == 'Draw') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (findwinner([[0, 0], [1, 1]]) == 'Pending') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (findwinner([[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]]) == 'B') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
