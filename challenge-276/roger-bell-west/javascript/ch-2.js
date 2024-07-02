#! /usr/bin/node

"use strict"

function maximumfrequency(a) {
    let c = new Map;
    for (let w of a) {
        if (c.has(w)) {
            c.set(w, c.get(w) + 1);
        } else {
            c.set(w, 1);
        }
    }
    const mx = Math.max(...c.values());
    return mx * [...c.values()].filter(v => v == mx).length;
}

if (maximumfrequency([1, 2, 2, 4, 1, 5]) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maximumfrequency([1, 2, 3, 4, 5]) == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
