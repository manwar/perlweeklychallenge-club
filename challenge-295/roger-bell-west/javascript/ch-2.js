#! /usr/bin/node

"use strict"

function jumpgame(a) {
    const target = a.length - 1;
    let here = new Set([0])
    let moves = 0;
    while (true) {
        moves += 1
        let there = new Set;
        for (let n of here) {
            for (let i = n + 1; i <= Math.min(n + a[n], target); i++) {
                there.add(i);
            }
            if (there.size == 0) {
                return -1;
            }
            if (there.has(target)) {
                return moves;
            }
            here = there
        }
    }
}

if (jumpgame([2, 3, 1, 1, 4]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (jumpgame([2, 3, 0, 4]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (jumpgame([2, 0, 0, 4]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
