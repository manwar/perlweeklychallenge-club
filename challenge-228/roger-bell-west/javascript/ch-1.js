#! /usr/bin/node

"use strict"

function uniquesum(a) {
    let c = new Map();
    for (let n of a) {
        if (c.has(n)) {
            c.set(n, c.get(n) + 1);
        } else {
            c.set(n, 1);
        }
    }
    let t = 0;
    for (const [k, v] of c) {
        if (v == 1) {
            t += k;
        }
    }
    return t;
}

if (uniquesum([2, 1, 3, 2]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (uniquesum([1, 1, 1, 1]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (uniquesum([2, 1, 3, 4]) == 10) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
