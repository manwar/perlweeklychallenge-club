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

function largestofthree(digits) {
    let ordered = [...digits];
    ordered.sort(function(a,b) {
        return a-b;
    });
    let mx = 0;
    for (let n = ordered.length - 1; n >= 0; n--) {
        for (let c of combinations(ordered, n + 1)) {
            let t = 0;
            for (let d of c) {
                t *= 10
                t += d;
            }
            if (t > mx && t % 3 == 0) {
                mx = t;
            }
        }
    }
    return mx;
}

if (largestofthree([8, 1, 9]) == 981) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (largestofthree([8, 6, 7, 1, 0]) == 8760) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
