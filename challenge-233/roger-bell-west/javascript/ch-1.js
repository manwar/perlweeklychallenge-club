#! /usr/bin/node

"use strict"

function similarwords(a) {
    let ct = new Map();
    let ac = 'a'.charCodeAt(0);
    for (let w of a) {
        let hs = new Set(w);
        let mask = 0;
        for (let c of hs) {
            mask = mask | (1 << (c.charCodeAt(0) - ac));
        }
        if (ct.has(mask)) {
            ct.set(mask, ct.get(mask) + 1);
        } else {
            ct.set(mask, 1);
        }
    }
    let pairs = 0;
    for (let cv of ct.values()) {
        if (cv > 1) {
            pairs += cv * (cv - 1) / 2;
        }
    }
    return pairs;
}

if (similarwords(['aba', 'aabb', 'abcd', 'bac', 'aabc']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (similarwords(['aabb', 'ab', 'ba']) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (similarwords(['nba', 'cba', 'dba']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
