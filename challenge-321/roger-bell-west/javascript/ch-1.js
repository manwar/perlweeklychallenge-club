#! /usr/bin/node

"use strict"

function distinctaverage(a0) {
    let a = [...a0];
    a.sort(function(a,b) {
        return a-b;
    });
    const offset = a.length - 1;
    const limit = Math.floor(a.length / 2);
    let res = new Set;
    for (let i = 0; i < limit; i++) {
        res.add(a[i] + a[offset - i]);
    }
    return res.size;
}

if (distinctaverage([1, 2, 4, 3, 5, 6]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (distinctaverage([0, 2, 4, 8, 3, 5]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (distinctaverage([7, 3, 1, 0, 5, 9]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
