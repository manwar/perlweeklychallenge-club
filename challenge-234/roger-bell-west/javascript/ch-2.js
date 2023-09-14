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

function unequaltriplets(utl) {
    let utc = new Map();
    for (let n of utl) {
        if (utc.has(n)) {
            utc.set(n, utc.get(n) + 1);
        } else {
            utc.set(n, 1);
        }
    }
    const kl = Array.from(utc.keys());
    if (kl.length < 3) {
        return 0;
    }
    let out = 0;
    for (let c of combinations(kl, 3)) {
        out += utc.get(c[0]) * utc.get(c[1]) * utc.get(c[2]);
    }
    return out;
}

if (unequaltriplets([4, 4, 2, 4, 3]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (unequaltriplets([1, 1, 1, 1, 1]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (unequaltriplets([4, 7, 1, 10, 7, 4, 1, 1]) == 28) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
