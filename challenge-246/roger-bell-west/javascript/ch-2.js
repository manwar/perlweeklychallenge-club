#! /usr/bin/node

"use strict"

function linearrecurrencesecondorder(seq) {
    const a = seq.slice(0, 3);
    const b = seq.slice(1, 4);
    const c = seq.slice(2, 5);
    const q = Math.floor((b[2] * a[0] - b[0] * a[2]) / (b[1] * a[0] - b[0] * a[1]));
    const p = Math.floor((a[2] - a[1] * q) / a[0]);
    return p * a[0] + q * a[1] == a[2] && p * b[0] + q * b[1] == b[2] && p * c[0] + q * c[1] == c[2]
}

if (linearrecurrencesecondorder([1, 1, 2, 3, 5])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!linearrecurrencesecondorder([4, 2, 4, 5, 7])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (linearrecurrencesecondorder([4, 1, 2, -3, 8])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
