#! /usr/bin/node

"use strict"

function totalzero(aa, bb) {
    if (aa == 0 && bb == 0) {
        return 0;
    }
    let a = aa;
    let b = bb;
    let ct = 1;
    while (true) {
        if (a == b) {
            return ct;
        }
        ct++;
        if (a > b) {
            a -= b;
        } else {
            b -= a;
        }
    }
}

if (totalzero(5, 4) == 5) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (totalzero(4, 6) == 3) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (totalzero(2, 5) == 4) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (totalzero(3, 1) == 3) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (totalzero(7, 4) == 5) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}

process.stdout.write("\n");
