#! /usr/bin/node

"use strict"

function frequencyequalizer(s) {
    let f = new Map();
    for (let c of s.split("")) {
        if (f.has(c)) {
            f.set(c, f.get(c) + 1);
        } else {
            f.set(c, 1);
        }
    }
    let v = [...f.values()].sort();
    if (v[0] == v[v.length-2] &&
        v[0] + 1 == v[v.length-1]) {
        return true;
    }
    return false;
}

if (frequencyequalizer("abbc")) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (frequencyequalizer("xyzyyxz")) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (!frequencyequalizer("xzxz")) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
