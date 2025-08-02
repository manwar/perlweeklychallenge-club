#! /usr/bin/node

"use strict"

function countcommon(a, b) {
    const aa = new Set(a);
    const bb = new Set(b);
    const intersect = new Set([...aa].filter(i => bb.has(i)));
    return intersect.size;
}

if (countcommon(['perl', 'weekly', 'challenge'], ['raku', 'weekly', 'challenge']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countcommon(['perl', 'raku', 'python'], ['python', 'java']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countcommon(['guest', 'contribution'], ['fun', 'weekly', 'challenge']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
