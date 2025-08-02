#! /usr/bin/node

"use strict"

function lastelement(a) {
    let b = [...a];
    while (true) {
        b.sort(function(aa, bb) {
        return aa - bb;
        });
        let f = b.pop();
        let s = b.pop();
        if (f > s) {
            b.push(f - s);
        }
        if (b.length == 0) {
            return 0;
        }
        if (b.length == 1) {
            return b[0];
        }
    }
}

if (lastelement([3, 8, 5, 2, 9, 2]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (lastelement([3, 2, 5]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
