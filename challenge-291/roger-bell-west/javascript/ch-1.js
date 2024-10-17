#! /usr/bin/node

"use strict"

function middleindex(a) {
    let r = a.reduce((x, y) => x + y);
    let l = 0;
    let latch = -1;
    a.forEach((c, i) => {
        r -= c;
        if (r == l && latch == -1) {
            latch = i;
        }
        l += c;
    });
    return latch;
}

if (middleindex([2, 3, -1, 8, 4]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (middleindex([1, -1, 4]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (middleindex([2, 5]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
