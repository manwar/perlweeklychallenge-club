#! /usr/bin/node

"use strict"

function missingnumber(l) {
    let v = new Set(l);
    for (let i = 0; i <= l.length; i++) {
        if (!v.has(i)) {
            return i;
        }
    }
    return 0;
}

if (missingnumber([0, 1, 3]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (missingnumber([0, 1]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
