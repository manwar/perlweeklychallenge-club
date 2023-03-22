#! /usr/bin/node

"use strict"

function specialbitcharacters(a) {
    let s = 0
    for (let v of a) {
        if (s == 1) {
            s = 2;
        } else {
            s = v;
        }
    }
    return s == 0;
}

if (specialbitcharacters([1, 0, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!specialbitcharacters([1, 1, 1, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
