#! /usr/bin/node

"use strict"

function zerofriend(a) {
    const b = Math.min(...a.map(x => Math.abs(x)));
    if (a.find(x => x == b) >= 0) {
        return b;
    }
    return -b;
}

if (zerofriend([4, 2, -1, 3, -2]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zerofriend([-5, 5, -3, 3, -1, 1]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zerofriend([7, -3, 0, 2, -8]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zerofriend([-2, -5, -1, -8]) == -1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (zerofriend([-2, 2, -4, 4, -1, 1]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
