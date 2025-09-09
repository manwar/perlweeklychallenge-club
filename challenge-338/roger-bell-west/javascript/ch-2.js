#! /usr/bin/node

"use strict"

function maxdistance(a, b) {
    const l1 = Math.min(...a);
    const h1 = Math.max(...a);
    const l2 = Math.min(...b);
    const h2 = Math.max(...b);
    return Math.max(h1 - l2, h2 - l1);
}

if (maxdistance([4, 5, 7], [9, 1, 3, 4]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxdistance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxdistance([2, 1, 11, 3], [2, 5, 10, 2]) == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxdistance([1, 2, 3], [3, 2, 1]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxdistance([1, 0, 2, 3], [5, 0]) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
