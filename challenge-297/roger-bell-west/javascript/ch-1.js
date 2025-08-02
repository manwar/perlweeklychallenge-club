#! /usr/bin/node

"use strict"

function contiguousarray(a) {
    const lm = Math.floor((1 + a.length) / 2) * 2;
    for (let l = lm; l >= 2; l -= 2) {
        for (let start = 0; start <= a.length - l; start++) {
            const end = start + l;
            if (a.slice(start, end).reduce((x, y) => x + y) * 2 == l) {
                return l;
            }
        }
    }
    return 0;
}

if (contiguousarray([1, 0]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (contiguousarray([0, 1, 0]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (contiguousarray([0, 0, 0, 0, 0]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (contiguousarray([0, 1, 0, 0, 1, 0]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
