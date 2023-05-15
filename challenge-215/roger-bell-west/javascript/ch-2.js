#! /usr/bin/node

"use strict"

function numberplacement(a0, ct) {
    let a = [1];
    a.push(...a0);
    a.push(1)
    let s = 0;
    let tt = 0;
    for (let i = 1; i < a.length; i++) {
        if (a[i - 1] == 1 && a[i] == 0) {
            s = i;
        } else if (a[i - 1] == 0 && a[i] == 1) {
            tt += Math.floor((i - s) / 2);
        }
    }
    return ct <= tt;
}

if (numberplacement([1, 0, 0, 0, 1], 1)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!numberplacement([1, 0, 0, 0, 1], 2)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (numberplacement([1, 0, 0, 0, 0, 0, 0, 0, 1], 3)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
