#! /usr/bin/node

"use strict"

function specialnumbers(a) {
    let t = 0;
    a.forEach((n, i) => {
        if (a.length % (i + 1) == 0) {
            t += n * n;
        }
    });
    return t;
}

if (specialnumbers([1, 2, 3, 4]) == 21) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialnumbers([2, 7, 1, 19, 18, 3]) == 63) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
