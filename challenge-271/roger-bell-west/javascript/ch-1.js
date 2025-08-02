#! /usr/bin/node

"use strict"

function maximumones(a) {
    const ax = a.map(r => r.reduce((x, y) => x + y));
    const am = Math.max(...ax);
    return ax.indexOf(am) + 1;
}

if (maximumones([[0, 1], [1, 0]]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumones([[0, 0, 0], [1, 0, 1]]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumones([[0, 0], [1, 1], [0, 0]]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
