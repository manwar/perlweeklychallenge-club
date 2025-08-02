#! /usr/bin/node

"use strict"

function maximumcount(a) {
    let pos = 0;
    let neg = 0;
    for (let n of a) {
        if (n > 0) {
            pos++;
        } else if (n < 0) {
            neg++;
        }
    }
    return Math.max(pos, neg);
}

if (maximumcount([-3, -2, -1, 1, 2, 3]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumcount([-2, -1, 0, 0, 1]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumcount([1, 2, 3, 4]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
