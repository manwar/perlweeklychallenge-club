#! /usr/bin/node

"use strict"

function divisiblepairs(a, k) {
    let ct = 0;
    for (let ai = 0; ai < a.length-1; ai++) {
        for (let bi = ai+1; bi < a.length; bi++) {
            if ((a[ai] + a[bi]) % k == 0) {
                ct++;
            }
        }
    }
    return ct;
}

if (divisiblepairs([4, 5, 1, 6], 2) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (divisiblepairs([1, 2, 3, 4], 2) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (divisiblepairs([1, 3, 4, 5], 3) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (divisiblepairs([5, 1, 2, 3], 4) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (divisiblepairs([7, 2, 4, 5], 4) == 1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}

process.stdout.write("\n");
