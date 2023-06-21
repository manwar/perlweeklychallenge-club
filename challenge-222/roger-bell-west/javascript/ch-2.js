#! /usr/bin/node

"use strict"

function lastmember(a0) {
    let a = a0;
    while (a.length > 1) {
        a.sort();
        const x = a.pop();
        const y = a.pop();
        if (x != y) {
            a.push(x - y);
        }
    }
    if (a.length == 0) {
        return 0;
    } else {
        return a[0];
    }
}

if (lastmember([2, 7, 4, 1, 8, 1]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (lastmember([1]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (lastmember([1, 1]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
