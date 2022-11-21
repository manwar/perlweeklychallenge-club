#! /usr/bin/node

"use strict"

function binaryflip(n) {
    let m = n;
    let r = 0;
    while (m > 0) {
        m >>= 1;
        r += 1;
    }
    return (1 << r) - 1 - n;
}

if (binaryflip(5) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (binaryflip(4) == 3) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (binaryflip(6) == 1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
