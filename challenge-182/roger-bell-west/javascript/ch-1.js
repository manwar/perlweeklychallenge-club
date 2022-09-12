#! /usr/bin/node

"use strict"

function maxindex(n) {
    let mxv = 0;
    let mxi = 0;
    n.forEach((v, i) => {
        if (i == 0 || v > mxv) {
            mxv = v;
            mxi = i;
        }
    });
    return mxi;
}

if (maxindex([5, 2, 9, 1, 7, 6]) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (maxindex([4, 2, 3, 1, 5, 0]) == 4) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (maxindex([4, 2, 3, 1, 4, 0]) == 0) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
