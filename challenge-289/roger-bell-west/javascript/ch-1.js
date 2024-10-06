#! /usr/bin/node

"use strict"

function thirdmaximum(a) {
    let p = [...new Set([...a])];
    p.sort(function(a,b) {
        return b - a;
    });
    if (p.length > 2) {
        return p[2];
    } else {
        return p[0];
    }
}

if (thirdmaximum([5, 6, 4, 1]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thirdmaximum([4, 5]) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (thirdmaximum([1, 2, 2, 3]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
