#! /usr/bin/node

"use strict"

function maximumxor(l) {
    let m = [];
    for (let ai = 0; ai < l.length-1; ai++) {
        for (let bi = ai + 1; bi < l.length; bi++) {
            m.push(l[ai] ^ l[bi]);
        }
    }
    return Math.max(...m);
}

if (maximumxor([1, 2, 3, 4, 5, 6, 7]) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumxor([2, 4, 1, 3]) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumxor([10, 5, 7, 12, 8]) == 15) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
