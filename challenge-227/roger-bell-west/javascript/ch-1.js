#! /usr/bin/node

"use strict"

function friday13th(y) {
    let f = 0;
    for (let m = 1; m <= 12; m++) {
        if (new Date(y, m-1, 13, 12, 0, 0).getDay() == 5) {
            f++;
        }
    }
    return f;
}

if (friday13th(2023) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
