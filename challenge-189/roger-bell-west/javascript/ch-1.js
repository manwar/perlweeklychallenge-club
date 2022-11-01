#! /usr/bin/node

"use strict"

function greatercharacter(a, k) {
    let aa = a;
    aa = aa.filter(i => i > k);
    aa.sort();
    if (aa.length > 0) {
        return aa[0];
    } else {
        return k;
    }
}

if (greatercharacter(['e', 'm', 'u', 'g'], 'b') == 'e') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (greatercharacter(['d', 'c', 'e', 'f'], 'a') == 'c') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (greatercharacter(['j', 'a', 'r'], 'o') == 'r') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (greatercharacter(['d', 'c', 'a', 'f'], 'a') == 'c') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (greatercharacter(['t', 'g', 'a', 'l'], 'v') == 'v') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
