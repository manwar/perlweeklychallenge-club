#! /usr/bin/node

"use strict"

function validator(a0) {
    let a = [...a0];
    a.sort();
    let l = a.length;
    if (a[0] == 0 && a[l - 2] == 0 && a[l - 1] == 1) {
        for (let i = 0; i < l; i++) {
            if (a0[i] == 1) {
                return i;
            }
        }
    }
    return -1;
}

function specialpositions(a) {
    let vr = new Array;
    let xs = new Set;
    a.forEach((row, y) => {
        let x = validator(row);
        if (x > -1) {
            vr.push([y, x]);
            xs.add(x);
        }
    });
    let xd = new Set;
    for (let x of xs) {
        let c = a.map(r => r[x]);
        if (validator(c) == -1) {
            xd.add(x);
        }
    }
    for (let x of xd) {
        xs.delete(x);
    }
    let t = 0;
    for (let [y, x] of vr) {
        if (xs.has(x)) {
            t++;
        }
    }
    return t;
}

if (specialpositions([[1, 0, 0], [0, 0, 1], [1, 0, 0]]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (specialpositions([[1, 0, 0], [0, 1, 0], [0, 0, 1]]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
