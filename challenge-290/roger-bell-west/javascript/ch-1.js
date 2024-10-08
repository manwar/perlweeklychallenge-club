#! /usr/bin/node

"use strict"

function doubleexist(a) {
    for (let i = 0; i < a.length - 1; i++) {
        for (let j = i + 1; j < a.length; j++) {
            if (a[i] == 2 * a[j] || a[j] == 2 * a[i]) {
                return true;
            }
        }
    }
    return false;
}

if (doubleexist([6, 2, 3, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!doubleexist([3, 1, 4, 13])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (doubleexist([2, 1, 4, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
