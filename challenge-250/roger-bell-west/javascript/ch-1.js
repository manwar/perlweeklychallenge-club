#! /usr/bin/node

"use strict"

function smallestindex(a) {
    let r = -1;
    a.forEach((n, i) => {
        if (r == -1 && n % 10 == i) {
            r = i;
        }
    })
    return r;
}

if (smallestindex([0, 1, 2]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (smallestindex([4, 3, 2, 1]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (smallestindex([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
