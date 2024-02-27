#! /usr/bin/node

"use strict"

function popcount64(x0) {
    const M1  = 0x5555555555555555n;
    const M2  = 0x3333333333333333n;
    const M4  = 0x0f0f0f0f0f0f0f0fn;
    const H01 = 0x0101010101010101n;
    let x = BigInt(x0);
    x -= (x >> 1n) & M1;
    x = (x & M2) + ((x >> 2n) & M2);
    x = (x + (x >> 4n)) & M4;
    return Number((x * H01) >> 56n);
}

function sumofvalues(a, k) {
    let s = 0;
    a.forEach((v, i) => {
        if (popcount64(i) == k) {
            s += v;
        }
    });
    return s;
}

if (sumofvalues([2, 5, 9, 11, 3], 1) == 17) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumofvalues([2, 5, 9, 11, 3], 2) == 11) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sumofvalues([2, 5, 9, 11, 3], 0) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
