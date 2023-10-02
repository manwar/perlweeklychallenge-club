#! /usr/bin/node

"use strict"

function emptyarray(a0) {
    let t = 0
    let a = a0;
    while (a.length > 0) {
        const i = a.indexOf(Math.min(...a));
        t += i + 1;
        a.splice(i, 1);
    }
    return t;
}

if (emptyarray([3, 4, 2]) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (emptyarray([1, 2, 3]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
