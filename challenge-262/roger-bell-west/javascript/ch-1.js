#! /usr/bin/node

"use strict"

function maxpositivenumber(a) {
    return Math.max(
        a.filter ( c => c > 0 ).length,
        a.filter ( c => c < 0 ).length
    );
}

if (maxpositivenumber([-3, 1, 2, -1, 3, -2, 4]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxpositivenumber([-1, -2, -3, 1]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxpositivenumber([1, 2]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
