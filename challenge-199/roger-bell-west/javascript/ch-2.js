#! /usr/bin/node

"use strict"

function goodtriplets(a, x, y, z) {
    let c = 0;
    for (let i = 0; i <= a.length - 3; i++) {
        for (let j = i + 1; j <= a.length - 2; j++) {
            if (Math.abs(a[i] - a[j]) <= x) {
                for (let k = j + 1; k <= a.length - 1; k++) {
                    if (Math.abs(a[j] - a[k]) <= y &&
                        Math.abs(a[i] - a[k]) <= z) {
                        c++;
                    }
                }
            }
        }
    }
    return c;
}

if (goodtriplets([3, 0, 1, 1, 9, 7], 7, 2, 3) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goodtriplets([1, 1, 2, 2, 3], 0, 0, 1) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
