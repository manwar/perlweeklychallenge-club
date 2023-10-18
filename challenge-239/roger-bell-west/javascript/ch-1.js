#! /usr/bin/node

"use strict"

function samestring(a, b) {
    return a.join("") == b.join("");
}

if (samestring(['ab', 'c'], ['a', 'bc'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!samestring(['ab', 'c'], ['ac', 'b'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (samestring(['ab', 'cd', 'e'], ['abcde'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
