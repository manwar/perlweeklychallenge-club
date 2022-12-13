#! /usr/bin/node

"use strict"

function specialintegers(n) {
    let o = 0;
    for (let i = 1; i <= n; i++) {
        let f = new Set();
        let s = true;
        for (let c of i.toString()) {
            if (f.has(c)) {
                s = false;
                break;
            } else {
                f.add(c);
            }
        }
        if (s == 1) {
            o++;
        }
    }
    return o;
}

if (specialintegers(15) == 14) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (specialintegers(35) == 32) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
