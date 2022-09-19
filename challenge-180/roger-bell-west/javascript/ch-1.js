#! /usr/bin/node

"use strict"

function firstunique(s) {
    let cc = new Map();
    s.split("").forEach( c => {
        if (cc.has(c)) {
            cc.set(c, cc.get(c) + 1);
        } else {
            cc.set(c, 1);
        }
    });
    let r = -1;
    s.split("").forEach((c, i) => {
        if (cc.has(c) && cc.get(c) == 1 && r == -1) {
            r = i;
        }
    });
    return r;
}

if (firstunique("Perl Weekly Challenge") == 0) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (firstunique("Long Live Perl") == 1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (firstunique("aabbcc") == -1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
