#! /usr/bin/node

"use strict"

function championteam(a) {
    let maxw = 0;
    let teamw = []
    a.forEach((w, i) => {
        const wins = w.reduce((x, y) => x + y);
        if (wins > maxw) {
            teamw = [];
            maxw = wins;
        }
        if (wins == maxw) {
            teamw.push(i);
        }
    });
    if (teamw.length == 1) {
        return teamw[0];
    }
    let bestt = teamw[0];
    for (let rt of teamw) {
        if (a[rt][bestt] == 1) {
            bestt = rt;
        }
    }
    return bestt;
}

if (championteam([[0, 1, 1], [0, 0, 1], [0, 0, 0]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (championteam([[0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (championteam([[0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (championteam([[0, 1, 1], [0, 0, 0], [0, 1, 0]]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (championteam([[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1], [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
