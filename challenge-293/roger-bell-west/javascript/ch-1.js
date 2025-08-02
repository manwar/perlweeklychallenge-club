#! /usr/bin/node

"use strict"

function counterify(a) {
    let cc = new Map;
    for (let x of a) {
        if (!cc.has(x)) {
            cc.set(x, 0);
        }
        cc.set(x, cc.get(x) + 1);
    }
    return cc;
}

function dvalue(a) {
    if (a[0] < a[1]) {
        return a[0] * 64 + a[1];
    } else {
        return a[1] * 64 + a[0];
    }
}

function similardominoes(a) {
    const c = counterify(a.map(x => dvalue(x)));
    let t = 0;
    for (let v of c.values()) {
        if (v > 1) {
            t += v;
        }
    }
    return t;
}

if (similardominoes([[1, 3], [3, 1], [2, 4], [6, 8]]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (similardominoes([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
