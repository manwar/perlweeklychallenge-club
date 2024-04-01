#! /usr/bin/node

"use strict"

function mergestrings(a, b) {
    let out = "";
    for (let i = 0; i < Math.max(a.length, b.length); i++) {
        if (i <= a.length - 1) {
            out += a.substring(i, i+1);
        }
        if (i <= b.length - 1) {
            out += b.substring(i, i+1);
        }
    }
    return out;
}

if (mergestrings('abcd', '1234') == 'a1b2c3d4') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (mergestrings('abc', '12345') == 'a1b2c345') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (mergestrings('abcde', '123') == 'a1b2c3de') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
