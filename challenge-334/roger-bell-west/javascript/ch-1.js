#! /usr/bin/node

"use strict"

function rangesum(a, s, e) {
    return a.slice(s, e + 1).reduce((x, y) => x + y);
}

if (rangesum([-2, 0, 3, -5, 2, -1], 0, 2) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (rangesum([1, -2, 3, -4, 5], 1, 3) == -3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (rangesum([1, 0, 2, -1, 3], 3, 4) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (rangesum([-5, 4, -3, 2, -1, 0], 0, 3) == -2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (rangesum([-1, 0, 2, -3, -2, 1], 0, 2) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
