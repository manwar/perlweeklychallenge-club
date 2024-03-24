#! /usr/bin/node

"use strict"

function multiplybytwo(a, start) {
    const p = new Set(a);
    let v = start;
    while (p.has(v)) {
        v *= 2;
    }
    return v;
}

if (multiplybytwo([5, 3, 6, 1, 12], 3) == 24) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (multiplybytwo([1, 2, 4, 3], 1) == 8) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (multiplybytwo([5, 6, 7], 2) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
