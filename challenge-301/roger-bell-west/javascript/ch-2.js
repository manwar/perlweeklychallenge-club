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

function hammingdistance(a) {
    let t = 0
    for (let i = 0; i <= a.length - 2; i++) {
        for (let j = i + 1; j <= a.length - 1; j++) {
            t += popcount64(a[i] ^ a[j]);
        }
    }
    return t;
}

if (hammingdistance([4, 14, 2]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (hammingdistance([4, 14, 4]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
