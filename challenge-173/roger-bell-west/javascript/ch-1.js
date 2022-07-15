#! /usr/bin/node

"use strict"

function esthetic10(n) {
    return esthetic(n, 10);
}

function esthetic(n0, base) {
    let n = n0;
    let pdigit = 0;
    let ch = false;
    while (n > 0) {
        let digit = n % base;
        if (ch && Math.abs(digit - pdigit) != 1) {
            return false;
        }
        ch = true;
        pdigit = digit;
        n = Math.floor(n / base);
    }
    return true;
}

if (esthetic10(5456)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (!esthetic10(120)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (esthetic10(12)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (esthetic10(5654)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (!esthetic10(890)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

process.stdout.write("\n");
