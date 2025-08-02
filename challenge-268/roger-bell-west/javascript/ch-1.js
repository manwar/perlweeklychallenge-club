#! /usr/bin/node

"use strict"

function magicnumber(a, b) {
    return Math.min(...b) - Math.min(...a)
}

if (magicnumber([3, 7, 5], [9, 5, 7]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (magicnumber([1, 2, 1], [5, 4, 4]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (magicnumber([2], [5]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
