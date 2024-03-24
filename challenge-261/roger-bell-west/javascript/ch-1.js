#! /usr/bin/node

"use strict"

function elementdigitsum(a) {
    let delta = 0;
    for (let n0 of a) {
        let n = Math.floor(n0 / 10);
        let m = 10;
        while (n > 0) {
            delta += (n % 10) * (m - 1);
            n = Math.floor(n / 10);
            m *= 10;
        }
    }
    return delta;
}

if (elementdigitsum([1, 2, 3, 45]) == 36) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (elementdigitsum([1, 12, 3]) == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (elementdigitsum([1, 2, 3, 4]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (elementdigitsum([236, 416, 336, 350]) == 1296) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
