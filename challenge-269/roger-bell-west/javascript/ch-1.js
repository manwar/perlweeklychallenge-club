#! /usr/bin/node

"use strict"

function bitwiseor(a) {
    return a.filter(n => n % 2 == 0).length >= 2;
}

if (bitwiseor([1, 2, 3, 4, 5])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (bitwiseor([2, 3, 8, 16])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!bitwiseor([1, 2, 5, 7, 9])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
