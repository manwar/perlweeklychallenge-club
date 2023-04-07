#! /usr/bin/node

"use strict"

function combinations(arr, k) {
    let c = [];
    for (let i = 0; i < k; i++) {
        c.push(i);
    }
    c.push(arr.length);
    c.push(0);
    let out = [];
    while (true) {
        let inner = [];
        for (let i = k-1; i >= 0; i--) {
            inner.push(arr[c[i]]);
        }
        out.push(inner);
        let j = 0;
        while (c[j] + 1 == c[j + 1]) {
            c[j] = j;
            j += 1;
        }
        if (j >= k) {
            break;
        }
        c[j] += 1;
    }
    return out;
}

function splitsameaverage(a) {
    let ss = a.reduce((x, y) => x + y, 0);
    let ml = a.length;
    let mx = Math.floor(ml / 2);
    let ssa = false;
    for (let n = 1; n <= mx; n++) {
        for (let c of combinations(a, n)) {
            let ca = c.reduce((x, y) => x + y, 0);
            if (ca / n == (ss - ca) / (ml - n)) {
                ssa = true;
                break;
            }
        }
        if (ssa) {
            break;
        }
    }
    return ssa;
}

if (splitsameaverage([1, 2, 3, 4, 5, 6, 7, 8])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!splitsameaverage([1, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (splitsameaverage([1, 2, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
