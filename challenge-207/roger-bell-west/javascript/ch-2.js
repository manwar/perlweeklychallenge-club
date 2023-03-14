#! /usr/bin/node

"use strict"

function h_index(c0) {
    let c = c0.sort(function(a, b) {
        return b-a;
    });
    let h = 0;
    c.forEach((x, i) => {
        if (i + 1 <= x) {
            h = i + 1;
        }
    });
    return h;
}

if (h_index([10, 8, 5, 4, 3]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (h_index([25, 8, 5, 3, 3]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
