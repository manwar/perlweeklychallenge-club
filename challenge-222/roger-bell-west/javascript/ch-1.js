#! /usr/bin/node

"use strict"

function matchingmembers(a) {
    let b = [...a];
    b.sort(function(a,b) {
        return a-b;
    });
    let o = 0;
    for (let i = 0; i < a.length; i++) {
        if (a[i] == b[i]) {
            o++;
        }
    }
    return o;
}

if (matchingmembers([1, 1, 4, 2, 1, 3]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (matchingmembers([5, 1, 2, 3, 4]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (matchingmembers([1, 2, 3, 4, 5]) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
