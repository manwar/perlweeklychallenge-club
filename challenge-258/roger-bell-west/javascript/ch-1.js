#! /usr/bin/node

"use strict"

function countevendigitsnumber(a) {
    let t = 0;
    for (let p of a) {
        let even = false;
        let pt = p;
        while (pt >= 10) {
            pt = Math.floor(pt / 10);
            even = !even;
        }
        if (even) {
            t += 1;
        }
    }
    return t;
}

if (countevendigitsnumber([10, 1, 111, 24, 1000]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countevendigitsnumber([111, 1, 11111]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (countevendigitsnumber([2, 8, 1024, 256]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
