#! /usr/bin/node

"use strict"

function maximisegreatness(a) {
    let b = a;
    b.sort(function(a, b) {
        return a - b;
    });
    let g = 0;
    for (let c of b) {
        if (c > b[g]) {
            g++;
        }
    }
    return g;
}

if (maximisegreatness([1, 3, 5, 2, 1, 3, 1]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximisegreatness([1, 2, 3, 4]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
