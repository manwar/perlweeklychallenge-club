#! /usr/bin/node

"use strict"

function binarydate(a) {
    return a.split("-").map(n => (n >>> 0).toString(2)).join("-");
}

if (binarydate('2025-07-26') == '11111101001-111-11010') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (binarydate('2000-02-02') == '11111010000-10-10') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (binarydate('2024-12-31') == '11111101000-1100-11111') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
