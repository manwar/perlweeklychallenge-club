#! /usr/bin/node

"use strict"

function mostfrequenteven(l) {
    let f = new Map();
    for (let n of l) {
        if (n % 2 == 0) {
            if (f.has(n)) {
                f.set(n, f.get(n) + 1);
            } else {
                f.set(n, 1);
            }
        }
    }
    if (f.size > 0) {
        let m = Math.max(...f.values());
        let l = Array.from(f.keys()).filter(i => f.get(i) == m);
        l.sort();
        return l[0];
    } else {
        return -1;
    }
}

if (mostfrequenteven([1, 1, 2, 6, 2]) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (mostfrequenteven([1, 3, 5, 7]) == -1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (mostfrequenteven([6, 4, 4, 6, 1]) == 4) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
