#! /usr/bin/node

"use strict"

function countequaldivisible(a, k) {
    let s = 0;
    for (let i = 0; i < a.length - 1; i++) {
        for (let j = i + 1; j < a.length; j++) {
            if (a[i] == a[j] && i * j % k == 0) {
                s++;
            }
        }
    }
    return s;
}

if (countequaldivisible([3, 1, 2, 2, 2, 1, 3], 2) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countequaldivisible([1, 2, 3], 1) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
