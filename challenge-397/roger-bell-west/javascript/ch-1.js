#! /usr/bin/node

"use strict"

function absentsmallestpositive(a) {
    const tot = a.reduce((x,y) => x+y);
    const ex = new Set([...a]);
    const mul = a.length;
    let n = 1;
    while (true) {
        if (n * mul > tot && !ex.has(n)) {
            return n;
        }
        n++;
    }
}

if (absentsmallestpositive([1, 2, 4, 5, 6]) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (absentsmallestpositive([-5, -2, -1, 3]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (absentsmallestpositive([1, 2, 3]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (absentsmallestpositive([2, 3, 7, 8]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (absentsmallestpositive([1, 1, 1, 10]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
