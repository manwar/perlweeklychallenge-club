#! /usr/bin/node

"use strict"

function maximumaverage(a, n) {
    let t = 0;
    for (let i = 0; i < n; i += 1) {
        t += a[i];
    }
    let mx = t;
    for (let i = n; i < a.length; i += 1) {
        t += a[i];
        t -= a[i - n];
        mx = Math.max(mx, t);
    }
    return mx / n
}

if (maximumaverage([1, 12, -5, -6, 50, 3], 4) == 12.75) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumaverage([5], 1) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
