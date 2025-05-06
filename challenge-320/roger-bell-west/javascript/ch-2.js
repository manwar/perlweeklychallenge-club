#! /usr/bin/node

"use strict"

function sumdifference(a) {
    let delta = 0;
    for (let x of a) {
        if (x >= 10) {
            let digitsum = 0;
            let xa = x;
            while (xa > 0) {
                digitsum += xa % 10;
                xa = Math.floor(xa / 10);
            }
            delta += x - digitsum;
        }
    }
    return delta;
}

if (sumdifference([1, 23, 4, 5]) == 18) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumdifference([1, 2, 3, 4, 5]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumdifference([1, 2, 34]) == 27) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
