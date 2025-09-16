#! /usr/bin/node

"use strict"

function peakpoint(a) {
    let h = 0;
    let o = 0;
    for (let p of a) {
        h += p;
        o = Math.max(o, h);
    }
    return o;
}

if (peakpoint([-5, 1, 5, -9, 2]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (peakpoint([10, 10, 10, -25]) == 30) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (peakpoint([3, -4, 2, 5, -6, 1]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (peakpoint([-1, -2, -3, -4]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (peakpoint([-10, 15, 5]) == 10) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
