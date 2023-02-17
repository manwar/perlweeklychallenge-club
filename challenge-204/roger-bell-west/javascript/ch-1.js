#! /usr/bin/node

"use strict"

function monotonicarray(l) {
    let d = [];
    for (let i = 0; i < l.length - 1; i++) {
        d.push(l[i + 1] - l[i]);
    }
    return (Math.min(...d) * Math.max(...d) >= 0);
}

if (monotonicarray([1, 2, 2, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!monotonicarray([1, 3, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (monotonicarray([6, 5, 5, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
