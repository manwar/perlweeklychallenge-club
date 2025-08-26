#! /usr/bin/node

"use strict"

function finalscore(a) {
    let p = [];
    for (let n of a) {
        switch (n) {
        case 'C':
            p.pop();
            break;
        case 'D':
            p.push(2 * p.at(-1));
            break;
        case '+':
            p.push(p.at(-2) + p.at(-1));
            break;
        default:
            p.push(parseInt(n));
        }
    }
    return p.reduce((x, y) => x + y)
}

if (finalscore(['5', '2', 'C', 'D', '+']) == 30) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (finalscore(['5', '-2', '4', 'C', 'D', '9', '+', '+']) == 27) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (finalscore(['7', 'D', 'D', 'C', '+', '3']) == 45) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (finalscore(['-5', '-10', '+', 'D', 'C', '+']) == -55) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (finalscore(['3', '6', '+', 'D', 'C', '8', '+', 'D', '-2', 'C', '+']) == 128) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
