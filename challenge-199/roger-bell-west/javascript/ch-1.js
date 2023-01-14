#! /usr/bin/node

"use strict"

function goodpairs(l) {
    let c = 0;
    let k = new Map();
    for (let i of l) {
        if (k.has(i)) {
            k.set(i, k.get(i) + 1);
        } else {
            k.set(i, 1);
        }
    }
    for (let v of k.values()) {
        c += v * (v - 1);
    }
    return c / 2;
}

if (goodpairs([1, 2, 3, 1, 1, 3]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goodpairs([1, 2, 3]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goodpairs([1, 1, 1, 1]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
