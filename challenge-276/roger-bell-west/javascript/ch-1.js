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

function completeday(a) {
    let ct = 0;
    combinations(a, 2).forEach((c) => {
        if ((c[0] + c[1]) % 24 == 0) {
            ct += 1;
        }
    });
    return ct;
}

if (completeday([12, 12, 30, 24, 24]) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (completeday([72, 48, 24, 5]) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (completeday([12, 18, 24]) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
