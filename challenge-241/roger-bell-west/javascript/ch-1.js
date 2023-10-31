#! /usr/bin/node

"use strict"

function arithmetictriplets(a, diff) {
    const vs = new Set(a);
    return a.filter(n => vs.has(n + diff) && vs.has(n + diff * 2)).length;
}

if (arithmetictriplets([0, 1, 4, 6, 7, 10], 3) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arithmetictriplets([4, 5, 6, 7, 8, 9], 2) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
