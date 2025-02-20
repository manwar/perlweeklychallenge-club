#! /usr/bin/node

"use strict"

function mindiff(a) {
    let md = 0;
    let n = false;
    for (let i = 0; i < a.length - 1; i++) {
        for (let j = i + 1; j < a.length; j++) {
            let diff = Math.abs(a[i] - a[j]);
            if (!n || diff < md) {
                md = diff;
                n = true;
            }
        }
    }
    return md;
}

if (mindiff([1, 5, 8, 9]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (mindiff([9, 4, 1, 7]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
