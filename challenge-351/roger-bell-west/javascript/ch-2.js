#! /usr/bin/node

"use strict"

function arithmeticprogression(a0) {
    const epsilon = 0.0001;
    let a = [...a0];
    a.sort(function(a,b) {
        return a-b;
    });
    const delta = a[1] - a[0];
    for (let i = 2; i < a.length; i++) {
        if (Math.abs(a[i] - a[i - 1] - delta) > epsilon) {
            return false;
        }
    }
    return true;
}

if (arithmeticprogression([1, 3, 5, 7, 9])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arithmeticprogression([9, 1, 7, 5, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!arithmeticprogression([1, 2, 4, 8, 16])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arithmeticprogression([5, -1, 3, 1, -3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (arithmeticprogression([1.5, 3, 0, 4.5, 6])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
