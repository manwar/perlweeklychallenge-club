#! /usr/bin/node

"use strict"

function killandwin(a) {
    return a.reduce((x, y) => x + y, 0);
}

if (killandwin([2, 3, 1]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (killandwin([1, 1, 2, 2, 2, 3]) == 11) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
