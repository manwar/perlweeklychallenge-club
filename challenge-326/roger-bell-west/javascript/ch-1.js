#! /usr/bin/node

"use strict"

function dayoftheyear(a) {
    let d1 = new Date(Date.parse(a));
    let v1 = d1.valueOf();
    d1.setMonth(0);
    d1.setDate(1);
    let v0 = d1.valueOf();
    return Math.floor(0.5 + (v1 - v0) / 86400000 + 1);
}

if (dayoftheyear('2025-02-02') == 33) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (dayoftheyear('2025-04-10') == 100) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (dayoftheyear('2025-09-07') == 250) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
