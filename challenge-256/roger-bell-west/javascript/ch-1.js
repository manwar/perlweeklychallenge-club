#! /usr/bin/node

"use strict"

function maximumpairs(a) {
    let n = 0;
    let r = new Set;
    for (let s of a) {
        const t = s.split("").reverse().join("");
        if (r.has(t)) {
            n++;
        } else {
            r.add(s);
        }
    }
    return n;
}

if (maximumpairs(['ab', 'de', 'ed', 'bc']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumpairs(['aa', 'ba', 'cd', 'ed']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumpairs(['uv', 'qp', 'st', 'vu', 'mn', 'pq']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
