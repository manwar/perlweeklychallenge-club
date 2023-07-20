#! /usr/bin/node

"use strict"

function zeroarray(a) {
    let s = new Set(a);
    s.delete(0);
    return s.size;
}

if (zeroarray([1, 5, 0, 3, 5]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zeroarray([0]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zeroarray([2, 1, 4, 0, 3]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
