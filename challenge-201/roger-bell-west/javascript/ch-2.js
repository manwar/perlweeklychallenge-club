#! /usr/bin/node

"use strict"

function pennypiles(n) {
    if (n == 0) {
        return 1;
    }
    let s = 0;
    let j = n - 1;
    let k = 2;
    while (j >= 0) {
        let t = pennypiles(j);
        if (Math.floor(k / 2) % 2 == 1) {
            s += t;
        } else {
            s -= t;
        }
        if (k % 2 == 1) {
            j -= k;
        } else {
            j -= Math.floor(k / 2)
        }
        k++;
    }
    return s;
}

if (pennypiles(5) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (pennypiles(10) == 42) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
