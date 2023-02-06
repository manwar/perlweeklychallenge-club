#! /usr/bin/node

"use strict"

function consecutiveodds(a) {
    let i = 0;
    for (let v of a) {
        if (v % 2 == 1) {
            i++;
            if (i >= 3) {
                return true;
            }
        } else {
            i = 0;
        }
    }
    return false;
}

if (consecutiveodds([1, 5, 3, 6])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!consecutiveodds([2, 6, 3, 5])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!consecutiveodds([1, 2, 3, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (consecutiveodds([2, 3, 5, 7])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
