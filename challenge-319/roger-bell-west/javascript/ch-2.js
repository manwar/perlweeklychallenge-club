#! /usr/bin/node

"use strict"

function minimumcommon(a, b) {
    const aa = new Set(a);
    const bb = new Set(b);
    const cc = new Set([...aa].filter(i => bb.has(i)));
    if (cc.size == 0) {
        return -1;
    } else {
        let o = [...cc];
        o.sort();
        return o[0];
    }
}

if (minimumcommon([1, 2, 3, 4], [3, 4, 5, 6]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (minimumcommon([1, 2, 3], [2, 4]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (minimumcommon([1, 2, 3, 4], [5, 6, 7, 8]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
